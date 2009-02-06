From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2009, #02; Wed, 04)
Date: Fri, 6 Feb 2009 19:15:58 +0100
Message-ID: <8c5c35580902061015q557c4807odc747672c65cc153@mail.gmail.com>
References: <7vr62dk6ru.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 19:17:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVVGb-0007Tc-RU
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 19:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbZBFSQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 13:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbZBFSQB
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 13:16:01 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:31384 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbZBFSQA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 13:16:00 -0500
Received: by fg-out-1718.google.com with SMTP id 16so581274fgg.17
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 10:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=L9B1F68slNNCpSRWTMz2XeqyzinRLbI2ayiOZPBmS/8=;
        b=lJ0h8Rhrmv0uU5zTgB4k0dABHlvaDXlj4oAI1BcjcgbeSpWEN3DhJqKgvjd/hf/jzn
         8ewZVGfO1KvqquvhmBVtb30KkiMQzG1esNUoOV6u6SgVv7p3gewLOdKwD2QLtSN4a/nD
         qmE6vcdU/PiJjlYczMKVeLYMWun5Xw1J0ckhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NLRKLCmXfBUv1g4IaQIvAhtof4Lc4EoelyDdO2uewsWDtm3gVCxFhJECfWpTN8a+oz
         CkTeIcmqsm3iawPiMdAP2sm8i9UbCadpUuNuqlObh8g5etQeR8V06rP+aWjGYp0gDXEP
         PEpWLg2Qiwri27+tpz64iMuWATZr/BsnW2yi4=
Received: by 10.86.94.11 with SMTP id r11mr324264fgb.53.1233944158740; Fri, 06 
	Feb 2009 10:15:58 -0800 (PST)
In-Reply-To: <7vr62dk6ru.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108766>

On Thu, Feb 5, 2009 at 02:32, Junio C Hamano <gitster@pobox.com> wrote:
> * lh/submodule-tree-traversal (Sun Jan 25 01:52:06 2009 +0100) 6 commits
>  - archive.c: add support for --submodules[=(all|checkedout)]
>  - tree.c: allow read_tree_recursive() to traverse gitlink entries
>  + Revert round #1 of the series
>  + builtin-ls-tree: enable traversal of submodules
>  + archive.c: enable traversal of submodules
>  + tree.c: add support for traversal of submodules
>
> Sorry, but what's the status of this one? I am not particularly
> interested in this new feature myself, so unless I hear otherwise from
> people, I'd like to keep this out of 1.6.2.

I'd like to see the first patch (tree.c: allow read_tree_recursive()
to traverse gitlink entries) get into 1.6.2 (that would allow me to
add some nifty tree traversal to cgit). But the rest of the patches
needs more discussion/review before they're even 'next'-worthy; I'll
try to post an updated series during the weekend.

--
larsh
