From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool--lib: add p4merge as a pre-configured
 mergetool option
Date: Wed, 28 Oct 2009 00:18:00 -0700
Message-ID: <7vy6mwt2af.fsf@alter.siamese.dyndns.org>
References: <d411cc4a0910271536u5817802at43f7477dd8ccabc7@mail.gmail.com>
 <20091027230043.GA11607@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:18:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N32nW-0007um-0B
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757535AbZJ1HSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 03:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757533AbZJ1HSF
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:18:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757506AbZJ1HSE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 03:18:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2715A881DC;
	Wed, 28 Oct 2009 03:18:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=lynGEa9GZfvYRKwM6eS6dHpsy+Q=; b=r4w3naoR52Zrd1WMRZ534wN
	8BISyASFtsGdSnh3KsznvrJ3P/pPZFM18lTS6KJwo61g1ALTQDctqFK6aLCy+kgX
	3JBIn8bjF/H86tdLrhu25gxB3roxeYwpuTJSez3WkJuFDYidc2zWGKP8UzIVDhEA
	zguxYjh0Wbxu+tmEwJpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Mn9KiPKmO8v3z6YkS5AZLciTCO+8HM3l4PgBj9bHjXrE+kfbb
	vyS3hSNy8eBWnqs9gP/pIPelP5nQQSU6F4RctghaISQHSDbrPSFkf5aEDSZBK9a2
	Oz3iheey8dllkWoxmQenNbbpGCHMW611ccOjgsbhrd+X1Z6nFSb6WCX3AU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ED8D7881DA;
	Wed, 28 Oct 2009 03:18:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A6D3D881D9; Wed, 28 Oct 2009
 03:18:01 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 097874CE-C392-11DE-A984-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131416>

Charles Bailey <charles@hashpling.org> writes:

> On Tue, Oct 27, 2009 at 03:36:49PM -0700, Scott Chacon wrote:
>> p4merge is now a built-in diff/merge tool.
>> This adds p4merge to git-completion and updates
>> the documentation to mention p4merge.
>> ---
>
> I approve (but haven't had a chance to test this).

Thanks; eventually you two need Sign-off and Acked-by, then, but I sense
that an undate to address the points below is in order?

> I'm just wondering, does this work well with unixes and Mac OS X? I
> think it's recommended install practice to symlink p4v as p4merge on
> *nix, but Mac OS X needs some sort of 'launchp4merge' to be called
> IIRC, or is this something that users can just configure with
> mergetool.p4diff.path?
