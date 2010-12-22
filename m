From: Andreas Ericsson <ae@op5.se>
Subject: Re: What's cooking in git.git (Dec 2010, #06; Tue, 21)
Date: Wed, 22 Dec 2010 12:39:29 +0100
Message-ID: <4D11E371.4000006@op5.se>
References: <7vlj3i5zz9.fsf@alter.siamese.dyndns.org> <AANLkTin_u9FiZf-hbnhY0Dp+LifctxH8wKDL=yRrSpm+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 12:39:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVN2k-0003lb-0J
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 12:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656Ab0LVLje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 06:39:34 -0500
Received: from mail-ey0-f171.google.com ([209.85.215.171]:53561 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab0LVLjd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 06:39:33 -0500
Received: by eyg5 with SMTP id 5so2577004eyg.2
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 03:39:32 -0800 (PST)
Received: by 10.213.22.209 with SMTP id o17mr5748599ebb.41.1293017971760;
        Wed, 22 Dec 2010 03:39:31 -0800 (PST)
Received: from [192.168.1.178] (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id t5sm4623444eeh.14.2010.12.22.03.39.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 03:39:30 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Thunderbird/3.1.7 ThunderGit/0.1a
In-Reply-To: <AANLkTin_u9FiZf-hbnhY0Dp+LifctxH8wKDL=yRrSpm+@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164078>

On 12/22/2010 12:05 PM, Thiago Farina wrote:
> 
> [1] Hope I will learn what this means and avoid it, something like,
> unnecessary, stupid, really trivial, etc...

churn:
Work for little or no benefit.
A patch that adds little or no value to the codebase by itself.

A patch that fixes a problem that isn't there in the real world but
could be there if some system somewhere followed some obscure standard
to the very letter is a typical example of code-churn.

A patch that introduces an poorly thought-out feature that nobody uses
is another common example, as is modifying code to accommodate adding
undefined features later. If the code-modifying is promptly followed
by a patch to introduce a new feature that relies on the new behaviour,
it's not considered churn since the new feature is already defined.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
