From: Johannes Gilger <heipei@hackvalue.de>
Subject: [StGit] Issue when using custom --prefix on 64bit-system
Date: Wed, 13 May 2009 11:52:27 +0200
Message-ID: <20090513095226.GA32648@dualtron.vpn.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 13 12:27:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Bg7-0001L7-V7
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 12:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758359AbZEMK05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 06:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758048AbZEMK05
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 06:26:57 -0400
Received: from avalon.gnuzifer.de ([78.46.211.2]:45709 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbZEMK04 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 06:26:56 -0400
X-Greylist: delayed 2087 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 May 2009 06:26:56 EDT
Received: from u-5-141.vpn.rwth-aachen.de ([137.226.101.141]:36283 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1M4B8C-0005MO-VB
	for git@vger.kernel.org; Wed, 13 May 2009 11:52:09 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
X-SA-Exim-Connect-IP: 137.226.101.141
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119027>

Hi there,

unless I'm doing something wrong (using "make prefix=$HOME/...  
install"), I think stg has a small glitch on some lib64-systems.

For me it complains that it can't find stgit.main, which is no surprise, 
since the sys.path only contains the 'lib' subdirs added in lines 
34-36, while for me the stgit-libs where installed in $PREFIX/lib64 
(this is on Gentoo AMD64 stable).

The simple fix would be to just extend the local_path with the same 
entries with "lib64", but I'm sure there is a better way ;)

Greetings,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://heipei.net
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
