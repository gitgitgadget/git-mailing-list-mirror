From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-svn: use YAML format for mergeinfo cache when
 possible
Date: Tue, 29 May 2012 13:48:45 -0700
Message-ID: <7vk3zu3e8i.fsf@alter.siamese.dyndns.org>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
 <20110823081546.GA28091@dcvr.yhbt.net>
 <7vobzgrrbg.fsf@alter.siamese.dyndns.org> <20120527192541.GA29490@burratino>
 <20120527201450.GA3630@dcvr.yhbt.net> <20120528003901.GA11103@burratino>
 <20120529002537.GA4575@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jason Gross <jgross@MIT.EDU>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 29 22:48:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZTLY-0002Y3-KV
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 22:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996Ab2E2Uss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 16:48:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35684 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754735Ab2E2Usr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 16:48:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B8FC9F96;
	Tue, 29 May 2012 16:48:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q6xWLV1n40pT6kVOdDdhNZoGk2A=; b=IstK9Z
	PpomViAeVM5j02sjy6e81LGIKyDneWWqHi0jDKXzDGZk/cqfzvJPrWPWoYi0hvYP
	/St2EG7O2rs1upr23e5W4t31rfC8po8IVPe3Fa2syEBrK56pOn0BZDBJkRi1C3MY
	EHCpvK3TER6yx7n1KWCAlGNtgy4L/WSVOXsds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=unKnTJsCFpuMywYKCxG8DFjvUF6AjaMr
	ghwvEGQGBHEY2GrQ1U/E6S0mCJx6TB6NxWTDL+ZcSmiu50eWGmHlgIn7POGY6+4f
	c8L9AQzIPeTgqjxA86+YGhrFCNSdWkNmc2RF3NUBX2on+eyiTVWIroFDjUmYo1IF
	xivVkU7+3qY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7307B9F95;
	Tue, 29 May 2012 16:48:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A3F09F94; Tue, 29 May 2012
 16:48:46 -0400 (EDT)
In-Reply-To: <20120529002537.GA4575@dcvr.yhbt.net> (Eric Wong's message of
 "Tue, 29 May 2012 00:25:37 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AFCC089C-A9CF-11E1-9A34-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198761>

Eric Wong <normalperson@yhbt.net> writes:

> Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Eric Wong wrote:
>> > Jonathan Nieder <jrnieder@gmail.com> wrote:
>> 
>> >> +package Git::SVN::Memoize::YAML;
>> >
>> > Can we use this as an opportunity to start splitting git-svn.perl into
>> > multiple .pm files?
>> 
>> Not a bad idea.  I've included an example patch to sanity-check the
>> approach below.
>
> Thank you.  I've signed-off and pushed that and your other two out to
> "master" on git://bogomips.org/git-svn

OK, I'll pull it before tagging -rc1.

Thanks.
