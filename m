From: "Abhijit Bhopatkar" <bain@devslashzero.com>
Subject: [Announce] teamgit-0.0.8 receipies preperations
Date: Sat, 22 Nov 2008 19:32:16 +0530
Message-ID: <2fcfa6df0811220602p103a51e8l6fdf2401b270240f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 22 15:03:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3t5Q-00043F-9b
	for gcvg-git-2@gmane.org; Sat, 22 Nov 2008 15:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758276AbYKVOCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2008 09:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758264AbYKVOCT
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Nov 2008 09:02:19 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:20754 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758242AbYKVOCR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2008 09:02:17 -0500
Received: by an-out-0708.google.com with SMTP id d40so587630and.1
        for <git@vger.kernel.org>; Sat, 22 Nov 2008 06:02:16 -0800 (PST)
Received: by 10.100.240.9 with SMTP id n9mr706367anh.125.1227362536677;
        Sat, 22 Nov 2008 06:02:16 -0800 (PST)
Received: by 10.100.137.17 with HTTP; Sat, 22 Nov 2008 06:02:16 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi ppl,

teamGit is a functional git gui written in qt, its ultimate aim is to
add functionality
on top of git targeted at small closely nit teams.

I have tagged the repo with v0.0.8!!!
You can now get the .deb from ubuntu intrepid ppa
deb http://ppa.launchpad.net/bain-devslashzero/ubuntu intrepid main
package name is teamgit.
The main project website is http://www.devslashzero.com/teamgit

There are many small changes and feature adds
you can take a look at repo here
http://gitorious.org/projects/teamgit/repos/mainline

The major feature add however is addition on **Advanced** menu.

This menu is constructed on the fly parsing output of 'git help --all'
Then when you click on a menu item it issues git help <command> ,
parses the manpage and presents its options in a guified form.
It even display nice tooltips describing the option.

This is just a first stage of the planned feature. Ultimately this advanced
menu will be just a 'Admin' feature.
People will be able to save the selected options and parameters as 'Receipies'
and can cook a nice receipes package particular to their needs/organisations.

The feature is not really complete yet, but you can issue simple
commands using it.
Ther _are_bugs_ but i couldn't wait to showcase this nifty feature.

Check out the screenshot
http://www.devslashzero.com/images/teamgitscreenshots/screenshot-teamgit22nov.png

Abhijit Bhopaktar
