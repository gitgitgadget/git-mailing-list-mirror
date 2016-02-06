From: Britton Kerin <britton.kerin@gmail.com>
Subject: is there interest in tooltip patches for gitk?
Date: Fri, 5 Feb 2016 20:48:11 -0900
Message-ID: <CAC4O8c-Q_or+EN55g3cMzindKzjWwFok9M6oFpNSRjVddjLLRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 06:48:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRvjq-0006Ty-C8
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 06:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbcBFFsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 00:48:13 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38556 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbcBFFsM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 00:48:12 -0500
Received: by mail-wm0-f45.google.com with SMTP id p63so52917128wmp.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 21:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=VECtIc7uipGSxR9sSdPBfO2X2wWai8zmC/9D/ge7u8Q=;
        b=ehGYVCT+CMCcD2JCMNfE9E3VJgRiEHoJ38klu0ECvMRUetHPQ2KDMnH/rQHQPGndnY
         oqq9kvmpOqtDXVR7NgopPqU+O7scD4IjObNL/7vaAkdcU6FssR0uFupxUQG421livLKD
         +zZsRPu4jUd+yB0vf6pwlMNqbmL+qG3/pBinKj8Fqx74S6Shj9Wm4Oma0WanRctyo8Ux
         cPeG/E/3kXw0ZydteqgyJOLNxRqrmpk43ZFUc9se0pi4QkdzR7sxTmsq1mKd1vBFke/W
         f2of5c79hFJAonYi0u5RuBxrUXoe55c7I4g83Lxe25S/cjLlm0uVGtPZkwFWAC+uIUT3
         si/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=VECtIc7uipGSxR9sSdPBfO2X2wWai8zmC/9D/ge7u8Q=;
        b=OTxP/HdwRvJ/n7mKw48fz8R4sZPdswa1SfKa5IbPu9UGqydxd/2rAXZ//8HrVK2jWm
         NwWljz40eTrrriHf1oZDFYBNJkX22udzTqi1kn8rJnS6VlYzn27xiDGFzJTBM94GeaWF
         FCgy4BOq+36bSv+mR85aXH379pCBMwtVudX4XvxjKPSfOdjDPjBaR0YkAGPiYPYkH0yF
         X1DdHblyJ/j4eu5gGKlSXi0hBR1ABl8cQLk+1uUt2xipOC/EycgoiKyS+a6hINkfRk2c
         FiDUA1DJ/pNDTAxr81rkfzLBRerpq8kZZWj8yUBtS1mQIHwF7DRKhW+nxv3KQ9SKsgD+
         d7CA==
X-Gm-Message-State: AG10YOTrFw2uysbzvmfhumRUqbAThRcK05YUxiXXn7h8FFRUujIep050rjThwnW+P1PX5ktckDAj6bUrN8tYIg==
X-Received: by 10.28.90.133 with SMTP id o127mr21176601wmb.101.1454737691160;
 Fri, 05 Feb 2016 21:48:11 -0800 (PST)
Received: by 10.194.178.161 with HTTP; Fri, 5 Feb 2016 21:48:11 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285679>

or would they be regarded as too tricky to keep in sync with
reality/other documentation?
