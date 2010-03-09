From: Yann Droneaud <yann@droneaud.fr>
Subject: wishlist: git send-email improvement
Date: Tue, 09 Mar 2010 18:21:46 +0100
Message-ID: <1268155306.4277.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 09 18:22:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np384-0004HL-HE
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 18:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128Ab0CIRVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 12:21:54 -0500
Received: from smtp2e.orange.fr ([80.12.242.113]:2197 "EHLO smtp2e.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791Ab0CIRVx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Mar 2010 12:21:53 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2e24.orange.fr (SMTP Server) with ESMTP id 7E8C58000F72
	for <git@vger.kernel.org>; Tue,  9 Mar 2010 18:21:47 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2e24.orange.fr (SMTP Server) with ESMTP id 70776800050D
	for <git@vger.kernel.org>; Tue,  9 Mar 2010 18:21:47 +0100 (CET)
Received: from iago.mandriva.com (LPuteaux-156-16-100-40.w80-12.abo.wanadoo.fr [80.12.80.40])
	by mwinf2e24.orange.fr (SMTP Server) with ESMTP id 5C3F68000F72
	for <git@vger.kernel.org>; Tue,  9 Mar 2010 18:21:47 +0100 (CET)
X-ME-UUID: 20100309172147377.5C3F68000F72@mwinf2e24.orange.fr
Received: by iago.mandriva.com (Postfix, from userid 10001)
	id 141FB517; Tue,  9 Mar 2010 18:21:46 +0100 (CET)
X-Mailer: Evolution 2.28.2-1.1mdv2010.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141835>

Hi,

Here's a little wishlist for send-email

- Use From: field extracted from patch:
  If there's no configuration for user.email and From: field is 
  different than default auto generated From: address, 
  git send-email should use the one in the patch as default.

- Use To: field extracted from patch
  I've setup format-patch to add a default To: field with
  format.headers="To: xxx@yyy". But git send-email did not use it and 
  ask for a To: value.
  If there's no --to or sendmail.to, send-email should use To: value 
  extracted from patch and ask for user confirmation.

I've tried to add the later to git-send-email, but failed to fix it by
now in a reasonable time amount.

Regards.

-- 
Yann Droneaud
