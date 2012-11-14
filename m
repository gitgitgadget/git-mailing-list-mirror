From: frank.jakop@tolina.de
Subject: How to setup gitweb with categories
Date: Wed, 14 Nov 2012 08:50:49 +0100
Message-ID: <OFAAF804D4.79EBACFB-ONC1257AB6.002B1126-C1257AB6.002B1B34@tolina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 14 08:51:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYXkW-0001do-Ma
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 08:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677Ab2KNHuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 02:50:50 -0500
Received: from mail.tolina.de ([212.202.167.194]:34037 "EHLO mail.tolina.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751918Ab2KNHuu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 02:50:50 -0500
Received: from [10.10.4.2] (port=33291 helo=mail.tolina.de)
	by mail.tolina.de with esmtp (Exim 4.76)
	(envelope-from <frank.jakop@tolina.de>)
	id 1TYXkE-0004v0-0P
	for git@vger.kernel.org; Wed, 14 Nov 2012 08:50:46 +0100
X-CTCH-RefID: str=0001.0A0C0205.50A34D56.0057,ss=1,re=0.000,fgs=0
X-KeepSent: AAF804D4:79EBACFB-C1257AB6:002B1126;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.2FP3 July 11, 2011
X-MIMETrack: Serialize by Router on SRVDOMINOEXT1/SESEXT(Release 8.5FP1|June 15, 2009) at
 14.11.2012 08:50:47,
	Serialize complete at 14.11.2012 08:50:47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209701>

Hello,

I'm trying to setup a gitweb frontend with categorized projects. I already 

have a plain project list running an changed my gitweb.conf so that it 
contains

our $projects_list_group_categories = "1";
our $project_list_default_category = "foo";

I'd now expect all projects to be shown under the category "foo", but upon 

reload nothing happens on the web page.

Can anyone tell me what's wrong?

Best regards

Frank
