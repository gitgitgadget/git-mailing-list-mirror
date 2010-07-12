From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH/RFC] test-lib: clean up trash* directories on SIGINT
Date: Sun, 11 Jul 2010 23:32:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1007112327150.10598@xanadu.home>
References: <AANLkTimnrLlprdScYDKHs_lIvFKc3K0n8U5vTzG_df2k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_Jrc6Y2lE4aqUM9R9rd5mkQ)"
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 05:32:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OY9kx-0004DL-Hq
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 05:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582Ab0GLDc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 23:32:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34922 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755530Ab0GLDc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 23:32:27 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L5F00BAKDU244A0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 11 Jul 2010 23:32:26 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTimnrLlprdScYDKHs_lIvFKc3K0n8U5vTzG_df2k@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Content-id: <alpine.LFD.2.00.1007112331510.10598@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150789>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_Jrc6Y2lE4aqUM9R9rd5mkQ)
Content-id: <alpine.LFD.2.00.1007112331511.10598@xanadu.home>
Content-type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-transfer-encoding: 8BIT

On Sun, 11 Jul 2010, Ævar Arnfjörð Bjarmason wrote:

> Is there any reason not to remove trash directories on SIGINT? It's
> annoying that trash directories are left when I cancel a test run.

What about tests that would fail due to some infinite loop?  The test 
would never complete until you manually interrupt it, and in that case 
the trash directory content might be valuable.  

You may do 'make clean' in the test directory to clean it.


Nicolas

--Boundary_(ID_Jrc6Y2lE4aqUM9R9rd5mkQ)--
