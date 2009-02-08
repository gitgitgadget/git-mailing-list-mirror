From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: gc considered dangerous
Date: Sun, 8 Feb 2009 19:24:33 +0100
Message-ID: <BD926B5C-60C2-4A62-9BBC-E31CB26B9BAC@zib.de>
References: <200902080347.25970.robin.rosenberg.lists@dewire.com> <alpine.DEB.1.00.0902081551290.10279@pacific.mpi-cbg.de> <200902081704.59439.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git ML <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 19:26:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWEMJ-0005BP-GM
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 19:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbZBHSYz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2009 13:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753049AbZBHSYz
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 13:24:55 -0500
Received: from mailer.zib.de ([130.73.108.11]:53242 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753020AbZBHSYy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2009 13:24:54 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n18IOddG015905;
	Sun, 8 Feb 2009 19:24:44 +0100 (CET)
Received: from [192.168.178.21] (brln-4db97d92.pool.einsundeins.de [77.185.125.146])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n18IOcbw024289
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 8 Feb 2009 19:24:39 +0100 (MET)
In-Reply-To: <200902081704.59439.robin.rosenberg.lists@dewire.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108998>


On Feb 8, 2009, at 5:04 PM, Robin Rosenberg wrote:

> s=F6ndag 08 februari 2009 15:56:38 skrev Johannes Schindelin:
>> Hi,
>>
>> On Sun, 8 Feb 2009, Robin Rosenberg wrote:
>>
>>> I've seen this. Running git gc on Windows, while having Elipse =20
>>> open can
>>> kill your object database.
>>
>> You had me really scared with the mail subject!
>
> Losing a repo *is* scary., especially if your boss is the one losing =
=20
> it.
> That should simply not happen unless there is a disk failure. =20
> Fortunately
> I believe the two lost branches did not contain anything useful.


If you have a backup of the corrupted repository right after it got
corrupted, you can create an index by running "git index-pack" on
the pack that is lacking an index.  This might rescue the lost
branches.

	Steffen
