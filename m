From: Stephen Bannasch <stephen.bannasch@gmail.com>
Subject: can I configure git clone to preserve the '.git' when it makes
 the initial dir
Date: Fri, 4 Jul 2008 18:28:33 -0400
Message-ID: <p06240819c49453b4beda@[192.168.1.105]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 00:46:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEu2s-0006tm-Un
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 00:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbYGDWpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 18:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752766AbYGDWpW
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 18:45:22 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:32078 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbYGDWpW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 18:45:22 -0400
Received: by yw-out-2324.google.com with SMTP id 9so606176ywe.1
        for <git@vger.kernel.org>; Fri, 04 Jul 2008 15:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:mime-version:message-id:date
         :to:from:subject:content-type;
        bh=5wKoELGJSVjnfBtJnHBanEea60LWlxBqTaQs4eb82yg=;
        b=aQ+M14KBL41npVHj86x4WkaRWyIBAzfVPSztd1Xdddah63h9WvXfwfGfVWJ2Zxcd0u
         hWTtdmGx4SqKUvdlcDdOGsqNtqMIWuIpl8V5/v0ou318T/7cu/2qHlRQa4zCTsBkP9UN
         5BAHiAIudYbFN6s+0Axbs3vQx4vY3YmxP5k8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:message-id:date:to:from:subject:content-type;
        b=PHKMoAxghfQVFyMH2aZa5mfCdpbaQ68X2VGfNoWqe9qqn37cE/BpXgWnivMzaw/pk7
         793vtBMzyF1Kn9gNe3P3mEnOwbvMxGgLze7x2qj4zUtoNnngc/waKxBL/kOunoNjUP4i
         DD2i8QcTuEWUcNve8KlNHWFuWwPLcq8OBf9tY=
Received: by 10.151.155.10 with SMTP id h10mr2775419ybo.96.1215211518883;
        Fri, 04 Jul 2008 15:45:18 -0700 (PDT)
Received: from ?192.168.1.105? ( [72.173.29.84])
        by mx.google.com with ESMTPS id y67sm2738403pyg.33.2008.07.04.15.45.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jul 2008 15:45:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87423>

As I'm moving to more use of git I find it very helpful to keep the 
'.git' suffix on the names of directories in which I have git 
repositories. This makes it easier to distinguish between checkouts 
using different SCMs.

Is there a way to configure git clone to preserve the '.git' suffix 
when creating a directory?

Thanks for any ideas.

-- 
- Stephen Bannasch
   Concord Consortium, http://www.concord.org
