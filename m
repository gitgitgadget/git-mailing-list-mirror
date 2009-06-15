From: Aaron Hicks <HicksA@landcareresearch.co.nz>
Subject: egit and RSA keys for SSH
Date: Mon, 15 Jun 2009 12:16:50 +1200
Message-ID: <F2969C1B08CBEE42B78C04C280D578E72CAF41E19B@donkey.landcare.ad.landcareresearch.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 15 02:23:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFzyY-0007Ln-IX
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 02:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbZFOAWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 20:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbZFOAWP
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 20:22:15 -0400
Received: from smtp.landcareresearch.co.nz ([202.27.240.35]:34472 "EHLO
	smtp.landcareresearch.co.nz" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752065AbZFOAWO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 20:22:14 -0400
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jun 2009 20:22:14 EDT
Received: from donkey.landcare.ad.landcareresearch.co.nz ([202.27.240.35]) by
 donkey.landcare.ad.landcareresearch.co.nz ([202.27.240.35]) with mapi; Mon,
 15 Jun 2009 12:16:52 +1200
Thread-Topic: egit and RSA keys for SSH
Thread-Index: AcntTpPfJuAPlzkcSwGKcMaEH+MDTQ==
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-hashedpuzzle: BQg= Ab5h Bc2D C8OW DAyP DlYB DwUE D62u EcFT EfWa Ew0/
 GhwK HXb4 JgGQ KrkK
 LBbq;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{D880C5C4-2BA8-43E8-A16D-27344DD70C94};aABpAGMAawBzAGEAQABsAGEAbgBkAGMAYQByAGUAcgBlAHMAZQBhAHIAYwBoAC4AYwBvAC4AbgB6AA==;Mon,
 15 Jun 2009 00:16:50
 GMT;ZQBnAGkAdAAgAGEAbgBkACAAUgBTAEEAIABrAGUAeQBzACAAZgBvAHIAIABTAFMASAA=
x-cr-puzzleid: {D880C5C4-2BA8-43E8-A16D-27344DD70C94}
acceptlanguage: en-US, en-NZ
x-tm-as-product-ver: SMEX-8.0.0.1181-5.600.1016-16704.003
x-tm-as-result: No--36.520900-8.000000-31
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121573>

Hi everyone,

We have a git repository set up with gitosis and it requires RSA keys to authenticate developers who have rights to push to this repository. i.e. they are blessed with write privileges. Github uses a similar method.

We use Eclipse, so we would like Eclipse to integrate with Git. So we grabbed egit from http://www.jgit.org/update-site and used the Eclipse installer (Like we do all the other Eclipse plug-in, given that the egit/jgit sites don't give instructions otherwise it seems to be the thing to do).

The problem is I can't see how to associate an RSA key in order to authenticate the SSH login with our gitosis repository (or GitHub). We have PuTTY installed and use Pageant to manage keys, and the required key is already loaded. We've used the 'import project' wizard, and initialised git in our project workspace, and though egit becomes aware that the project is a git repository, there seem to be no menu items for associating an RSA key with a remote repository.

The wish list states that this is already implemented, but gives _no_ instructions on how it's done. http://git.or.cz/gitwiki/EclipsePluginWishlist#SupportforSSHKeys

I've searched the git mailing archives for egit with RSA, key, SSH, and private key, and though there is a lot of discussion about egit and keys and sessions, there are no instructions on how it's done.

Can anyone help with this?

Regards,

Aaron Hicks


Please consider the environment before printing this email
Warning:  This electronic message together with any attachments is confidential. If you receive it in error: (i) you must not read, use, disclose, copy or retain it; (ii) please contact the sender immediately by reply email and then delete the emails.
The views expressed in this email may not be those of Landcare Research New Zealand Limited. http://www.landcareresearch.co.nz
