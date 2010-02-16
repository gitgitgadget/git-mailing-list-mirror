From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [RFC] git clone --checkout <branch>
Date: Tue, 16 Feb 2010 18:48:42 +0800
Message-ID: <be6fef0d1002160248h7410d4edu6e3ed1fd27c40059@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 16 11:48:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhKz3-0000rU-S6
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 11:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975Ab0BPKso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 05:48:44 -0500
Received: from mail-iw0-f185.google.com ([209.85.223.185]:53724 "EHLO
	mail-iw0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833Ab0BPKsm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 05:48:42 -0500
Received: by iwn15 with SMTP id 15so5661282iwn.19
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 02:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=bvn5ZSEmnSrbdoRt0m6fR2bTUP4jjtp1tZoSGnfXXJk=;
        b=QCDZQ/OdM5pmzoPzl1s11nt03QifiieVPJl+wAi8K3BJ+8PE8jjzWVSFZytUaZNAC4
         QMcX4gCvvz6gNcDanKFaJZ5TyN4Mg7xauRDx+o4MRDNo9U057tbWS3rwpCSZC8g3nHr6
         JBIiOBqDnhnOBN8yfhj6CG/DWPgGU3n1jZjvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=c8/SiOWURg9elzaSrXD1vDAIRAFuEnwEhUfcCHy6XLY3ia3HxzD1Po3DmR+FneAoQD
         QhZj6ND83gijwY//+g6bY19bpletFU1feG95oOjPSp7M6JMzlHJKtH7OUjpLlNkREHdz
         UZk9/5Q2NpJDkjInoeK0MTwxdbMyT3Q5/9FQg=
Received: by 10.231.182.142 with SMTP id cc14mr7756903ibb.81.1266317322041; 
	Tue, 16 Feb 2010 02:48:42 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140093>

Hi,

what do you guys think about allowing users to specify the branch to
checkout when cloning, instead of the default HEAD of the to-be-cloned
repository?

-- 
Cheers,
Ray Chuan
