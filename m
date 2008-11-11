From: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
Subject: Forcing encoding for "git commit"
Date: Tue, 11 Nov 2008 20:10:46 +0300
Message-ID: <85647ef50811110910p7b40fd5dhcd79f8ae38709b95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 18:12:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzwmb-00043d-JW
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 18:12:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbYKKRKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 12:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbYKKRKt
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 12:10:49 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:24619 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbYKKRKs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 12:10:48 -0500
Received: by fg-out-1718.google.com with SMTP id 19so77431fgg.17
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 09:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=LBpASMI0OQNtqQVl3GIEtn+SxduSx/Ud4U9YFrHYZL0=;
        b=T2epay895XIHzEHjugn+xljSjmlq9MWraYoTAIa6pX1InA8BQnWt5UD3NmqAngLSqj
         vkkca7BlNiMstVhlKO0rzW60ZaNYb6R2DlxksDaBpJZvE4aRBRoTuM2o601PyI15JiAQ
         ibl1vcEAMmh5r+zxJS4skVBxESA99GzFaVBX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=O5nlSwoVL62DXnAJTqLkSgLInyO04PrRCI4k+AoeFkdePke7TCVp/usP0w015182N9
         CyuPgUmSk24FIDHxbYZN1cGiRXpckSeyoz4Ew/M+B7DIaOTG6B5gWdOATB11+4PcVilm
         Allge7DujF0k/7t7ctsUvNUeQadRO8zjwz5Ic=
Received: by 10.181.24.14 with SMTP id b14mr2565701bkj.104.1226423446414;
        Tue, 11 Nov 2008 09:10:46 -0800 (PST)
Received: by 10.180.230.10 with HTTP; Tue, 11 Nov 2008 09:10:46 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100653>

I would like to see a possibility to force encoding for the "git
commit" command. Currently only way to change encoding used by "git
commit" is to set "i18n.commitencoding" configuration variable. But
there is no way to override this variable for the specific commit like
it is possible for "show" and "log" commands.

This would be useful when git is invoked from the tools. Currently
tools have to query configuration variable and to encode message
according to the value of the variable. And it might happen that not
all characters produced by tool are supported by target encoding.
Forcing the encoding, would have allowed the tool use the suitable
encoding without changing user preferences.

Regards,
Constantine
