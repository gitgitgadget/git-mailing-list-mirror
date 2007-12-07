From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: RAM consumption when working with the gcc repo
Date: Fri, 7 Dec 2007 22:25:50 +0100
Message-ID: <e5bfff550712071325k3d4dadf2gf34c069022cc005@mail.gmail.com>
References: <9e4733910712071207p750c14f4h7abc5d637da3a478@mail.gmail.com>
	 <Pine.LNX.4.64.0712071323260.12607@asgard.lang.hm>
	 <alpine.LFD.0.99999.0712071529580.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, "Jon Smirl" <jonsmirl@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:26:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0kiA-0006al-Ud
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 22:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbXLGVZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 16:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754302AbXLGVZw
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 16:25:52 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:54574 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051AbXLGVZv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 16:25:51 -0500
Received: by rv-out-0910.google.com with SMTP id k20so827285rvb
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 13:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rZMtELTWSyicNZr+JFozg2rvxHckHTb1gM4Qb16A3HE=;
        b=ohbr/nX9odx2x/6zDxONLBiswMT0xcFMFD5LhtOkgD7TO2vAYLE6J9Wj9F0rya9ViRpAWptCLHnOCn2YrL8FplvIAFSUBOTCpZx2rZsdnKuECL6hkmFghc2D8B6/FqzahHxgLJczJ2Ss93zFinYza9iJeyQgEW1s7ioDD5RjtfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uwayzLTSDW5ha1guAVIxcJXyUv2KmpwTSkNue7IMmbyPLsvQPhNZSzKU95a0+GqNHt+r/AzTZ2seJCb0PAdw2pT/8o83G41BOKn1sCg7sYJhQbWV2H5GEq2rWTkLFTpr3a0oMdmtl5X6rOT2g4QKOsM5KNvt0kiFrfrkj44PKm4=
Received: by 10.141.89.13 with SMTP id r13mr2964901rvl.1197062750950;
        Fri, 07 Dec 2007 13:25:50 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Fri, 7 Dec 2007 13:25:50 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712071529580.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67461>

On Dec 7, 2007 9:46 PM, Nicolas Pitre <nico@cam.org> wrote:
>
> The other 2.3GB is hard to explain.
>

BTW does exist a tool to profile memory consumption by each source
level struct / vector/ or any other data container?

Valgrind checks mainly memory leaks, callgrind gives profiling
information in terms of call graphs and times/cycles consumed by each
function.

What I _really_ would like it's a tool that allows me to *easily*
check how much memory is used in a given point in time by each data
container at source level.

Something like this:


At checkpoint "trigger_now":

struct my_data is instantiated 120234 times
struct super_delta is instantiated 100000 times


At checkpoint "trigger_also_now":

struct my_data is instantiated 12 times
struct super_delta is instantiated 70 times

.....


That would be AWSOME!!! a super debugging killing tool!

Thanks
Marco
