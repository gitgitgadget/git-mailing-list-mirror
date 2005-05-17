From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] improved delta support for git
Date: Tue, 17 May 2005 21:10:30 +0200
Message-ID: <20050517191029.GQ13508@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.62.0505112309480.5426@localhost.localdomain> <20050517182232.GM13508@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 17 21:14:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY7SR-0005pO-LF
	for gcvg-git@gmane.org; Tue, 17 May 2005 21:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVEQTKq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 15:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVEQTKp
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 15:10:45 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:34718 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261444AbVEQTKc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2005 15:10:32 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4HJAUS8004859
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 17 May 2005 19:10:30 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4HJAUDa004858
	for git@vger.kernel.org; Tue, 17 May 2005 21:10:30 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050517182232.GM13508@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,
okay I got it. Fragmentation:

before:
	(medion) [/scratch/mutt/mutt-cvs] du -sh --apparent-size .git/objects/
	49M     .git/objects/

after:
	(medion) [/scratch/mutt/mutt-cvs] du -sh --apparent-size .git/objects/
	19M     .git/objects/

cvs repository:

	(faui00u) [~/work/git/yagf] du -sh --apparent-size ../../mutt/cvsrepository
	33M     ../../mutt/cvsrepository

Sincerely,
	Thomas
