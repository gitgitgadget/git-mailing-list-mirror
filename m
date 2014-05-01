From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Evil
Date: Thu, 01 May 2014 14:27:43 -0500
Message-ID: <5362a02f5a153_76612eb2f071@nysa.notmuch>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
 <xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
 <536106EA.5090204@xiplink.com>
 <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
 <536152D3.5050107@xiplink.com>
 <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
 <536173F5.7010905@xiplink.com>
 <53617877b41a9_41a872f308ef@nysa.notmuch>
 <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 21:38:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfwoM-0004aR-AX
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 21:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbaEATiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 15:38:22 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:39436 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbaEATiV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 15:38:21 -0400
Received: by mail-yk0-f181.google.com with SMTP id q200so3011479ykb.26
        for <git@vger.kernel.org>; Thu, 01 May 2014 12:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=uI4C2BUJDnPnrekm80LA03HLwY5+qvW/Xxr4w1o8A+w=;
        b=kA+tqakk3xz7iASuekEq5o/fJ7ITbcb6kgp5KpP8Xe4OBaeJ5qTp/GpHTsMu74Vnb3
         hAKYOoKGQ4RMFXeBu8D89ULUcO8YIdAxNKhlw3TeFy8W7bi7dm8Jjz2t97iBLIwiSA8H
         Wb6nUPhgYSwFS1geNUlQlSb9uf2+mNUV65sDfRgXl7KPjhFKWMS9iD+JdmLuCya43Cnl
         Apy647VYDM5WTEEDcJZ9m4rkA0a5XlDoRaNMLSfrmtuLRg4ZZoH6otMrM84O0y6+j2fT
         fTFRHS6x8Qbo5rkemhg3L58vlUnnz+s6lzZcG5hwe9RrI33qp5pCpYtoW8veDOh4/fP+
         7wUg==
X-Received: by 10.236.25.207 with SMTP id z55mr17787796yhz.34.1398973100851;
        Thu, 01 May 2014 12:38:20 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id e4sm24735364yhe.42.2014.05.01.12.38.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 12:38:19 -0700 (PDT)
In-Reply-To: <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247831>

brian m. carlson wrote:
> At work, we have a workflow where we merge topic branches as
> non-fast-forward, so that we have a record of the history (including
> who reviewed the code), but when we want to just update our local
> branches, we always want fast-forward:
> 
>   git checkout maintenance-branch
>   # Update our maintenance branch to the latest from the main repo.
>   git pull --ff-only

If we make it the default, you only need to type `git pull`.

>   git pull --no-ff developer-remote topic-branch

I don't see anything wrong with having to type --no-ff if that's what
you really want.

>   git push main-repo HEAD

main-repo/maintenance-branch should be the upstream of
maintenance-branch, in which hase:

% git push

-- 
Felipe Contreras
