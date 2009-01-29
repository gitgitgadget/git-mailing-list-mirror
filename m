From: Charles Earl <charles.cearl@gmail.com>
Subject: Appropriateness of git for digital video production versioning
Date: Thu, 29 Jan 2009 10:36:55 -0500
Message-ID: <8c4a72800901290736p4952e53byddca243f300dd8af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 16:38:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSYyI-0005vL-9K
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 16:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827AbZA2Pg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 10:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753117AbZA2Pg5
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 10:36:57 -0500
Received: from mail-gx0-f21.google.com ([209.85.217.21]:55059 "EHLO
	mail-gx0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbZA2Pg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 10:36:56 -0500
Received: by gxk14 with SMTP id 14so6525438gxk.13
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 07:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=AbyZAOkr9e0WS4zTKp8voaNrkNKTVV0UI90A6X4BeV8=;
        b=mfS9Nu0gS/PNfbuK/5ccYp7sXP7bmtQoZdmJamHlTMpr4OHt4NewhTQoUj0WCt6JKf
         pAPpZ6DHI13KcQVSQcU662JxYdwuWTMNAHmAP8yFPHngYuu7vQZM9Ecs4SS+m9yrklEh
         ewLnvoz5yEMp0k4SbJ50e0gaJXNYtLkWFaPoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=vfll6lZ78waRQfQd5ZDNZiUGJjLOVkfVn9Yg2GFnclzUGRhBUL38cy2iq5fTv8xDDw
         jXuTNWIEJz/GIzT2Pu2U1PBJ6Pc0ofNO6pvlCHlwIEDEcVb4WSnLhjN4YWHIcg/BbCyJ
         oLcMOw3yCwYzFqtBYBHpKvsU5cYeuqyVVfVMM=
Received: by 10.150.227.9 with SMTP id z9mr102516ybg.9.1233243415229; Thu, 29 
	Jan 2009 07:36:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107694>

Hi,
Are there past instances of git having been adapted to support version
control of digital media production workflow?
I'm evaluating CMS and versioning systems for the backend of a SaaS
for digital media production workflow.
The bulk of content stored is binary data -- there have been posts on
this about integration of various binary diff implemetations with git.
The versioning of metadata, scripts, project structure seems to argue
for applicability of system such as git -- these fit the paradigm of
traditional scm.
Example content is from media production suites such as Adobe After
Effects/Premier: video, compositions, etc.
I'd also like the object storage to be in S3/Amazon BlockStore or
similar remote stores.
Charles
