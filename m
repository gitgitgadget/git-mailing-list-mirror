From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: Reduced privileges install
Date: Mon, 20 Sep 2010 14:18:14 -0500
Message-ID: <Dts0bHMc9kE-cOU9Qd837Yx7BmckeN1wFi8J63y34-aZ-rCqt4SE3A@cipher.nrlssc.navy.mil>
References: <325786BC-5F54-47B5-AEF5-7FDAD9BEA4BA@kellerfarm.com> <BvHZDf7-epsPOl8y5QrLcsmYgobmFUo7HwZanlekCciU8I-jiKPVRw@cipher.nrlssc.navy.mil> <23ECDEF1-BDEC-45CC-B0CC-7E1A7BFE00BB@kellerfarm.com> <CWxE18Hq1ro8utv-_dFm1ZaVIKpCDTv-TbEB4u_l84GvbeJh1vKing@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 21:18:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxlsc-0007KI-8F
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 21:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757135Ab0ITTSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 15:18:17 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51413 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab0ITTSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 15:18:16 -0400
Received: by mail.nrlssc.navy.mil id o8KJIEbe024075; Mon, 20 Sep 2010 14:18:14 -0500
In-Reply-To: <CWxE18Hq1ro8utv-_dFm1ZaVIKpCDTv-TbEB4u_l84GvbeJh1vKing@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 20 Sep 2010 19:18:14.0941 (UTC) FILETIME=[92DEF4D0:01CB58F8]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156652>

On 09/20/2010 02:12 PM, Brandon Casey wrote:
> On 09/20/2010 11:56 AM, Andrew Keller wrote:

>> The quick-install-man target still failed,
> 
> Strange.  You tried _after_ you installed git right?

Oh, _and_ you're building within a checkout of the git
repository right?  Not, within the extraction of a tar archive?

i.e.

   git clone git://git.kernel.org/pub/scm/git/git.git
   cd git
   make

not

   wget http://kernel.org/pub/software/scm/git/git-1.7.2.3.tar.gz
   tar zxf git-1.7.2.3.tar.gz
   cd git
   make

-Brandon
