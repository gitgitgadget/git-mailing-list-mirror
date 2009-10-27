From: =?ISO-8859-1?Q?Peter_Od=E9us?= <peter.odeus@gmail.com>
Subject: From 200 to 404 to 407.
Date: Tue, 27 Oct 2009 11:18:44 +0100
Message-ID: <82fd2c5d0910270318wc30bc44tfd3362933d3f62cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 11:18:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2j8c-0005vA-Vf
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 11:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbZJ0KSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 06:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbZJ0KSl
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 06:18:41 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:60810 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbZJ0KSk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 06:18:40 -0400
Received: by fxm18 with SMTP id 18so12797926fxm.37
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 03:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=3FulU3HUNBjE0d8B21pCEz8ES3veArdUyqV6sgnLP94=;
        b=ixjKbXO0VCnsYohCm42F5/9zwJzA0+kG6xc9fEJm8bFYkfrwU66j8/QLOoWeI0FqdP
         A/afYKd75Vil7BOzIyGiVH7n6oVE54p5Rc+l8iJVqVMD/SjNEUE/SBMCjYaUvUt6dXsL
         uO4lR5AptysurmpuA22j5U1ClQdwK6hF/vhnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=oFHQfbF1IoNdhyRuuqLR4/meby3xYav+bdjG4YciG4vL8/aiSUhb9A88Qp6zojjoH8
         M4W8ZGiDAOY327xpBBWfkXZVEF6+s5x1I+k6toQ1SWaDFzesnfEbhq23C+CluRmAU0qP
         S12G8MdKGHg/IVuHV5i26RV6sEI3kAs5ukxMs=
Received: by 10.204.23.203 with SMTP id s11mr729807bkb.17.1256638724657; Tue, 
	27 Oct 2009 03:18:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131323>

Hi,

Doing a "git clone..." using authenticated proxy (set in $http_proxy):

Upon initial success (HTTP 200) and receiving a single HTTP 404 (not
found), every GET after that renders a HTTP 407 (Proxy authentication
required).

curl -I "url_giving_http_407" comes out just fine as a HTTP 200.

Bug or just me?
