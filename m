From: Charles <hobbesc7@gmail.com>
Subject: libexec path
Date: Wed, 4 Feb 2009 18:53:05 -0500
Message-ID: <86293c1a0902041553s26e74a50kbf5e8f71aad557a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 00:54:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUrZi-0007Ad-Rx
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 00:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404AbZBDXxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 18:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754992AbZBDXxJ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 18:53:09 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:58093 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbZBDXxH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 18:53:07 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1390657fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 15:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=VpLzr7+SmuF6hFf2GCWRvhszepI+nqrvINcbTbvTCBk=;
        b=mN/LQBIoVlDowBLaaJBgU5HTkNtE91MbZcLY6/52BarVjFNwzvq/20nni6IzF1kmNA
         zfZvB8R7yboHqVIyZ3tdrtaOMwXAljoj0p9dTvH9QdcKfmOKCDCZTSLFDduAyOfHHRdJ
         3JjDFxTLDIioFuXfLOwFiJbzX6bP1eCRAITzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=o15Qm0+XUabTiGREvVps0agp9yIRTJEcKYGe7bSjYMKAnGHuJAmLm9Ev3W/8hnLVRm
         bzRKprrKJkZ9WK0uQQz2GU/a7EhCX3WTm13fhR1UgySXc3oJUc9aiQrt7wwr34fo3O/n
         +VnSY2iFUGRTjG4WiXhVaNtqZSbWhrJOdfVt8=
Received: by 10.181.144.10 with SMTP id w10mr2695788bkn.84.1233791586201; Wed, 
	04 Feb 2009 15:53:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108472>

How come in git-gui/GIT-GUI-VARS

gitexecdir is set to '/usr/local//usr/local/
libexec/git-core/'

when my configure prefix is "/usr/local" ?

Everything else ends up in /usr/local as it should, but libexec ends
up in /usr/local/usr/local

I'm cloning from the latest stuff.
