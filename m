From: ashish <ashish.chandrakant@gmail.com>
Subject: git exit with error code 1
Date: Sun, 1 Jan 2012 06:41:00 -0800 (PST)
Message-ID: <1325428860448-7142041.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 01 15:41:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RhMay-0001Bf-4d
	for gcvg-git-2@lo.gmane.org; Sun, 01 Jan 2012 15:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628Ab2AAOlC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jan 2012 09:41:02 -0500
Received: from sam.nabble.com ([216.139.236.26]:35055 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563Ab2AAOlB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jan 2012 09:41:01 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <ashish.chandrakant@gmail.com>)
	id 1RhMaq-0005AH-Kz
	for git@vger.kernel.org; Sun, 01 Jan 2012 06:41:00 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187822>


Ant script to run clone
<target name="clone" description="get the latest files">	
	<delete includeemptydirs="true">
<filesetdir=&quot;/opt/cruisecontrol-bin-2.8.4/projects/Mss/copyExample/local_copy/Mss&quot;
defaultexcludes=&quot;false&quot;>
<include name="**/*" />
</fileset>
</delete>
<exec executable="git"
dir="/opt/cruisecontrol-bin-2.8.4/projects/Mss/copyExample/local_copy/Mss">
	<arg line="clone -o fl ssh://git@ipaddress/git/run.git Mss" />
	</exec>		
</target>
In my current CruiseControl setup I am running the following target:
<modificationsetquietperiod=&quot;60&quot;>
<git
localworkingcopy="${projects.dir}/${project.name}/local_copy/${project.name}/"/>
</modificationset>

Running cruisecontrol gives git exit with error code 1. I guess
modificationset is not able to find git local working copy.
 Any help would be welcome and greatly appreciable .

--
View this message in context: http://git.661346.n2.nabble.com/git-exit-with-error-code-1-tp7142041p7142041.html
Sent from the git mailing list archive at Nabble.com.
