From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git.pm
Date: Fri, 11 May 2012 11:10:23 -0700
Message-ID: <7vobpulhbk.fsf@alter.siamese.dyndns.org>
References: <CAB3zAY3-Bn86bCr7Rxqi4vxbYFxUesLwm8gddxyMSexov2tOhw@mail.gmail.com>
 <CAFouetgwRpB1GFJOC8PTVryVY-94S3xa5ZiSaWQWoz070qQ-6g@mail.gmail.com>
 <CAB3zAY0NeXuH-wXyYkbim5U74eANY4hq5D6SsVLu3KeUqHFqzQ@mail.gmail.com>
 <20120426203136.GA15432@burratino>
 <CAB3zAY3VHtUobJfJ7=nSKb_6uJOXLGVHzR18qV6txPkzf54cDw@mail.gmail.com>
 <86likyy7ub.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Subho Banerjee <subs.zero@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>, git <git@vger.kernel.org>
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Fri May 11 20:10:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSuIS-0001rf-Bl
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 20:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933067Ab2EKSK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 14:10:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47731 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932215Ab2EKSKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 14:10:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C34C874E;
	Fri, 11 May 2012 14:10:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S+hdjVmPapZ6vc+rGHfY3nK+es0=; b=tvwS8H
	shL3mYs10dINHezxMNZ4eQYQ4vHQXA76OivhVXNYObasAF9bJnIgHvgXKiOs0LOf
	71csnGbymPeoyqHhvqFVgl4djhTzpVv6zrARK2+5c8b8T7/6cxo/F/byanFyFro/
	1VVwPie2Ewqb5K0dyinoeaQOpNtNejm7m5Hy8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BtEubMtLht6zNyp4sOP41hlHuSvswJ0X
	i2Aft7p/PVK57IECJHeDzNsgY4Zcv/SWVy1Y4LeAEejeB2meTA+xne3l8tZCvCLK
	hcv5nKIKV1wEbxb7W5Oci4ZU5YYHOOm8h+QgX649vORMnA0ylJ+uNYQQB/3XGZ/F
	w0QpHld1dyw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 231AB874C;
	Fri, 11 May 2012 14:10:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAAFA874B; Fri, 11 May 2012
 14:10:24 -0400 (EDT)
In-Reply-To: <86likyy7ub.fsf@red.stonehenge.com> (Randal L. Schwartz's
 message of "Fri, 11 May 2012 09:56:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9485F8CA-9B94-11E1-B29C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197685>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Subho" == Subho Banerjee <subs.zero@gmail.com> writes:
>
> Subho> I have started looking into how the error catching mechanism
> Subho> implemented right now. I have looked into the more modern error
> Subho> catching/throwing mechanisms in use in perl, and I am of the opinion
> Subho> that Try::Simple would probably be the best candidate for being the
> Subho> new error catching mechanism. I also wanted to discuss some aspects of
> Subho> the changes to be made -
>
> Try::Tiny is preferred to Try::Simple.

Thanks for an expert input; could you give another comparison between
Try::Tiny vs the use of bare "eval / if ($@)"?
