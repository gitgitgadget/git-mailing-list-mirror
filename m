From: Brian Swetland <swetland@google.com>
Subject: something like git-for-each-ref's --format for commits?
Date: Sun, 6 Jan 2008 00:52:21 -0800
Organization: Google, Inc.
Message-ID: <20080106085221.GA1729@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 09:53:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBRFx-0007Kb-5y
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 09:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbYAFIwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 03:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbYAFIwp
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 03:52:45 -0500
Received: from smtp-out.google.com ([216.239.33.17]:20955 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbYAFIwo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 03:52:44 -0500
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id m068qdO5024916
	for <git@vger.kernel.org>; Sun, 6 Jan 2008 08:52:40 GMT
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:subject:message-id:mime-version:
	content-type:content-disposition:organization:user-agent;
	b=qkaG6jBXlB+UYsP1zbAiEMclA8Ax+MavFB6Yzpo712gxTRQmFXA6rVRDVvXOePBIk
	tHky87S0ujSO3MVqQ9NTg==
Received: from bulgaria (bulgaria.corp.google.com [172.18.102.38])
	by zps37.corp.google.com with ESMTP id m068qcpS025225
	for <git@vger.kernel.org>; Sun, 6 Jan 2008 00:52:38 -0800
Received: by bulgaria (Postfix, from userid 1000)
	id D88561224A3; Sun,  6 Jan 2008 00:52:21 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69718>


I'm trying to obtain various information about commits from a script.
The --format option to git-for-each-ref would be perfect, except that
it only operates on refs, not arbitrary commit objects.

The --pretty=format:... option for git-log, etc has the annoying
property of giving you <unknown> instead of an empty string if an
item isn't example (say if you use %b on a commit with no body).

Am I missing some obvious solution here?  

Thanks,

Brian
