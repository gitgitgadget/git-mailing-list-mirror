From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] gitk: use themed tk widgets
Date: Fri, 17 Apr 2009 19:46:24 +0100
Message-ID: <49E8CE80.9040308@users.sourceforge.net>
References: <873ac8m8jg.fsf@users.sourceforge.net> <alpine.DEB.1.00.0904171206290.6675@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, paulus@samba.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 17 20:49:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lut7Z-0003DO-PO
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 20:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761476AbZDQSqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 14:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761235AbZDQSqo
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 14:46:44 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:45232 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761404AbZDQSqn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2009 14:46:43 -0400
Received: from [172.23.170.147] (helo=anti-virus03-10)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Lut5E-0001ve-L4; Fri, 17 Apr 2009 19:46:40 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out1.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1Lut5E-0004fA-5P; Fri, 17 Apr 2009 19:46:40 +0100
Received: from [192.168.0.25] (pc025.patthoyts.tk [192.168.0.25])
	by badger.patthoyts.tk (Postfix) with ESMTP id 9D3165182B;
	Fri, 17 Apr 2009 19:46:39 +0100 (BST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <alpine.DEB.1.00.0904171206290.6675@intel-tinevez-2-302>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 17 Apr 2009, Pat Thoyts wrote:
> 
>>   With Tk 8.5+ use the themed widgets to improve the appearence
>>   on Windows and MacOSX. On X11 less difference is apparent but
>>   users can select alternate themes by setting *TkTheme in the
>>   resource database (eg: *TkTheme: clam)
>>
>>   With Tk 8.6 there is a built-in font selection dialog and this
>>   patch will make use of that when available as on Windows and
>>   MacOSX it calls the native font selection dialog.
> 
> I had several conflicts applying your patch, and I do not have object 
> a346bd5 here (not even fetching from Paul's repository), but I fixed them 
> all up.  (In function setoptions(), you seemed to remove a part asking 
> about the windowingsystem being "aqua", but my gitk did not have that.)
> 
> The end result can be marveled at in 4msysgit's 'ttk' branch.
> 
> I did not have time to go through your changes, though.
> 
> But can I place another wish with you?  It all looks nicer now, except the 
> text which is not anti-aliased...  Any chance to fix that?

Anti-aliased text is a feature of Tk 8.5 plus the support in your server
and the chosen fonts. Not much to be done about that except choose a
nice font. On Windows Tahoma and Consolas should look fine.

I suspect the reason you have conflicts is the patch is generated
against the gitk repository and not the git repository. There are some
commits in gitk that have not been merged to git yet and my patch lives
on top of those.

Pat Thoyts

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQCVAwUBSejOf2B90JXwhOSJAQI5LwQAkyP+975JkafktWYCe3Agd+i8tWrXqf0E
NJqB/yF/WCNvqF8sVYzSnUdlxNDGalxE5Ehnoudg3Ca3AYm0LGsIgmNOBFXK+t9w
hUKBIYwMfXInHzoJLVqzQ0n7Ql0o6XopgzyT8KW6ec5Vwkgosc3Y7PqX5VqOsCmo
eBU+8JkfnfE=
=GPY9
-----END PGP SIGNATURE-----
