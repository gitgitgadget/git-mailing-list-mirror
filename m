From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Merge, rebase and whitespace fixes
Date: Mon, 29 Jun 2009 21:18:36 +0200
Message-ID: <cb7bb73a0906291218m3ba43109s35cad87efc5161a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 29 21:18:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLMNL-0004Kh-71
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 21:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbZF2TSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 15:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbZF2TSf
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 15:18:35 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:56945 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbZF2TSe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 15:18:34 -0400
Received: by bwz9 with SMTP id 9so3467619bwz.37
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=bsO3U4v3MRSAnM9Ym0BLo0wK610woizJg50UVt54BuU=;
        b=Q0m0HQ92MK3m23X6Su56OgHsxLB+VonjNAK/g3SJBxZVfqcVlwxnBCtCzO9d3f+fS8
         fZqJ4od8tGRDwUsfcSX8+CSrAjXkUbw70OXJGddd6H7aUovYmPSu3e949HCb5V8mes6Y
         csot7YxYjQrQy/hc3narfwijFwa6LLba1/TtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Jf4xKKcZ6pUbYApw5qbQ6sJ5TBiKbjFsLaeNPd6aiEz7BeRBTH7r8jkNlT9HK6P7xr
         omUuoKi7iva7Qbky9RPs7XugMexFDamuwJUG1vTcz8o0xxtoHTcLknjXCFDwBLw4lZbk
         iOVeYTmEwpVGgbgcNh+oh+j/LN3aa+aBEvhkA=
Received: by 10.204.71.210 with SMTP id i18mr7503006bkj.48.1246303116798; Mon, 
	29 Jun 2009 12:18:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122454>

Hello all,

recently a tree I've been working on received some thorough whitespace
adjustments (changing indents from spaces to tabs). This results in
annoying conflicts when running merges or rebases with my local
branches. I tried googling around but I couldn't find any helpful
hints on how to make git cope with this. Any suggestions?

-- 
Giuseppe "Oblomov" Bilotta
