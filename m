From: Josef Wolf <jw@raven.inka.de>
Subject: What about SHA-1 collisions?
Date: Tue, 6 Nov 2012 21:26:43 +0100
Message-ID: <20121106202643.GF28437@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 21:27:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVpk3-0006w1-W8
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 21:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584Ab2KFU1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 15:27:11 -0500
Received: from quechua.inka.de ([193.197.184.2]:46786 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141Ab2KFU1K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 15:27:10 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1TVpjp-0008Et-GM; Tue, 06 Nov 2012 21:27:09 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 0B6AA760DF; Tue,  6 Nov 2012 21:26:43 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209119>

Hello,

we all know, the probability for SHA-1 collisions is very, very low, almost
non-existant. But we also know that they are not impossible.

Just for curiosity: what would happen if such a collision would occur within
one repository?
