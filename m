From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Thunderbird and patches (was Re: [PATCH v2] Enable setting attach
   as the default in .gitconfig   for git-format-patch.)
Date: Mon, 09 Feb 2009 16:13:36 -0600
Message-ID: <1quO9vKdveU3UD9xhBB6YkuoBUyUsLvXylSjOkZKRByKfUxgId9fwQ@cipher.nrlssc.navy.mil>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de> <49903521.1060101@codeweavers.com> <49903B27.8070608@beonex.com> <49904DE7.2080205@codeweavers.com> <4990519C.8060601@drmicha.warpmail.net> <499058B4.4070009@beonex.com> <qXxPO6LuQr7-9QoWMdojOMbuADIJ55oaOVr5t_8eLGR9vvNpW72wyA@cipher.nrlssc.navy.mil> <49907F75.2050100@beonex.com> <alpine.DEB.1.00.0902092013260.10279@pacific.mpi-cbg.de> <4990820B.504@beonex.com> <r57oMSnamWCJ1G1-r98G6mYQjX0YNpQz1OzEBHSrDifmBU_ir2P77A@cipher.nrlssc.navy.mil> <49908927.2030408@beonex.com> <49908B1A.7040101@
 beonex.com> <kCHkjagMqmrTXbd229odxLGt0neIkfVZDCJPnhpXGVU71q9GcXEmPw@cipher.nrlssc.navy.mil> <4990A7D6.5090709@beonex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeremy White <jwhite@codeweavers.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Ben Bucksch <ben.bucksch.news@beonex.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 23:15:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWePh-0006QP-Hg
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 23:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbZBIWOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 17:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbZBIWOJ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 17:14:09 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60848 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbZBIWOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 17:14:09 -0500
Received: by mail.nrlssc.navy.mil id n19MDbN8031551; Mon, 9 Feb 2009 16:13:37 -0600
In-Reply-To: <4990A7D6.5090709@beonex.com>
X-OriginalArrivalTime: 09 Feb 2009 22:13:37.0374 (UTC) FILETIME=[A7D5CFE0:01C98B03]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109145>

Ben Bucksch wrote:
> On 09.02.2009 22:03, Brandon Casey wrote:
>> > So, TB *does* save it correctly, byte-for-byte.
>>
>> Sorry, but I think you did your comparison wrong.  Possibly the tool
>> which extracted the email from the cyrus server performed the same
>> transformation that Thunderbird does.
>>    
> 
> No. Cyrus stores each mail in its own file. All I did was:
> TB | File | Save as.... | "1.eml"
> scp root@<imap server>:/<mailbox store path>/<mail folder path>/749\. 2.eml
> md5sum 1.eml 2.eml
> b98d288357e384b8f58fe332ed65748b  1.eml
> b98d288357e384b8f58fe332ed65748b  2.eml
> (the md5sum will be different for you, as my mail contains the Received:
> headers from my server.)
> Given that I don't think TB changes the email on the server, what TB
> saved is exactly what I received, verbatim, on the wire.

Any thoughts on why I get different results from

  TB | File | Save as... | 1.eml

and

  TB | View | Message Source ... File | Save Page as | 2.eml

-brandon
