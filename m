From: "Gustaf Hendeby" <hendeby@gmail.com>
Subject: Difference in how "git status" and "git diff --name-only" lists filenames
Date: Sun, 2 Dec 2007 15:04:06 +0100
Message-ID: <bf7b2dda0712020604x209d6665i9ab58b32834b2cee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 02 15:04:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IypQt-0004hO-4G
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 15:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbXLBOEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 09:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752264AbXLBOEJ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 09:04:09 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:35938 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219AbXLBOEI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 09:04:08 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2377104rvb
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 06:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=YQGYNfeQ8Tx1jYOh3+POtMbUoNRyGUDYgmfess+OF2A=;
        b=k3+tbebZnzvbL+dcDk0l9d0k9YpckFCgkILbxT74u7svn5UtH9PRYPvl6vVl00fPdlL8qT3zdkVvrZcRK+Ld/XoxVHu8X3PyxtmIyS0NZ4NhgeKd2ma0F/YqFqbd1u+QJodcTGGm1recqCELs+gr6/uxOnH3D11AH3Isq5B22ws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Zt4zUqT6IuYLch5cbg8KxLchMMFkMlCV+lTjKze1Ecs325krmt69+SK1PRt/A6j8e/QOY3+fpKnAvX9IAtgq25FldLb0vkKBHY1FL+aai8tbyflXj9PmZZRSq8zNJBvKFpPLWlO8GwpMYcVUYnFo1n7ipnymcP6WABdU65O1RBo=
Received: by 10.141.205.10 with SMTP id h10mr5045841rvq.1196604246083;
        Sun, 02 Dec 2007 06:04:06 -0800 (PST)
Received: by 10.140.173.1 with HTTP; Sun, 2 Dec 2007 06:04:06 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66779>

A while ago 'git status' was patched to report relative pathnames.  (I
like that change it makes cut'n'paste easier.)  However, 'git diff
--name-only' and 'git diff --name-status' (other commands as well),
which gives in a sense similar output has not been changed the same
way.  Is this intentionally, or just because no one has stepped up and
provided a patch?  If the difference is to stay, maybe this should be
reflected in the help texts to avoid any confusion.

/Gustaf
