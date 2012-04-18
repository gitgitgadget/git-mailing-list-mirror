From: Stepan Koltsov <stepancheg@mx1.ru>
Subject: Re: [PATCH] stg delete --empty
Date: Wed, 18 Apr 2012 15:23:26 +0400
Message-ID: <37A023AD-BCA9-41B8-A9DA-23D1FA5B3827@mx1.ru>
References: <B940726E-2CFA-45CB-8B81-A8F4268D51A6@jetbrains.com> <CAHkRjk7EH8m09Qx-SH2E1NHARL5yZq9M=mOKrG56LiTUY1ArhQ@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Stepan Koltsov <Stepan.Koltsov@jetbrains.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 13:23:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKSzB-000719-Vj
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 13:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500Ab2DRLXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 07:23:40 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:42208 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751528Ab2DRLXj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 07:23:39 -0400
Received: by lahj13 with SMTP id j13so5613480lah.19
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 04:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :content-type:message-id:cc:x-mailer:from:subject:date:to
         :x-gm-message-state;
        bh=zJYjugRdXc3dKlz93UDzaZhuMm2Yu5QZOhTARTxAdl4=;
        b=EQcZfbNjHadP7TJyzpjFADodg8oT+GWH0QU8x+BDdjjCRNu10MXVP3vtdm7NvEspbs
         sPqlSB1b/P/0D2rJneKqR742dIG/z26XwxigdGB9Bjz2aUL4wtZ3CIHN+U9f0uExNBm5
         KgqEUFP5wF+nB+45KcFVQlJFSpMJdS37UqSIEr4KzV426/iI3p6kVDVA5WhUQOat9e69
         SyEbf6s4AyaxvZcoiRnXe44pD1u9fKrCsAul720sqkQF0pDs+xF62IevbHT1pmf2uBUm
         4+wbdFzqVetoVziSB1zpz1EyJjXifpI4IFJOPzal9dmzI83wf5+8lhmLyeBWUR+x2VFn
         5OOw==
Received: by 10.152.147.129 with SMTP id tk1mr1660006lab.47.1334748217711;
        Wed, 18 Apr 2012 04:23:37 -0700 (PDT)
Received: from [10.245.81.68] ([83.149.8.219])
        by mx.google.com with ESMTPS id pb13sm25984501lab.16.2012.04.18.04.23.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Apr 2012 04:23:35 -0700 (PDT)
In-Reply-To: <CAHkRjk7EH8m09Qx-SH2E1NHARL5yZq9M=mOKrG56LiTUY1ArhQ@mail.gmail.com>
X-Mailer: iPhone Mail (9B176)
X-Gm-Message-State: ALoCoQkBbDxTuJR7g/NgMj212OMVMfSbsjlCOMAX4mdoJS23E5k+kqdgo7/IxJ+dPLLF/nIt6vyf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195858>

On 18.04.2012, at 15:03, Catalin Marinas <catalin.marinas@gmail.com> wrote:

> On 11 April 2012 15:12, Stepan Koltsov <Stepan.Koltsov@jetbrains.com> wrote:
>> `stg delete --empty` deletes all empty patches in series. Command
>> does nothing and exits with zero code if all patches are not empty.
> 
> Thanks for the patch but there is already 'stg clean' with the same
> functionality.

My bad. Thank you.

-- 
Stepan
