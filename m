From: Kirill <kirillathome@gmail.com>
Subject: Re: [GITK PATCH 3/3] gitk: strip prefix from filenames in 
	subdirectories
Date: Tue, 23 Feb 2010 17:20:57 -0500
Message-ID: <f579dd581002231420l2fd81b19n5b1cf2887ada2871@mail.gmail.com>
References: <f579dd581002200847o340a3eb9l50d0f1329d4e2c23@mail.gmail.com>
	 <alpine.DEB.1.00.1002201847290.20986@pacific.mpi-cbg.de>
	 <a5b261831002200948v3c01708dv3e42d08d42e3119@mail.gmail.com>
	 <alpine.DEB.1.00.1002201920350.20986@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.1002231748320.3980@intel-tinevez-2-302>
	 <alpine.DEB.1.00.1002231810020.3980@intel-tinevez-2-302>
	 <alpine.DEB.1.00.1002231811021.3980@intel-tinevez-2-302>
	 <f579dd581002231142v6a937ac0xdc9618f2a468989d@mail.gmail.com>
	 <alpine.DEB.1.00.1002232148470.3980@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Pat Thoyts <patthoyts@googlemail.com>,
	Paul Mackerras <paulus@samba.org>, msysgit@googlegroups.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 23 23:21:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk37t-0003I3-K3
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 23:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428Ab0BWWVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 17:21:01 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49170 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348Ab0BWWVA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 17:21:00 -0500
Received: by wya21 with SMTP id 21so844800wya.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 14:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=H8G8JjAQNZhPmDXw8icfl+Vmc2hbQZrEnOqYU1lzH6I=;
        b=St8KzepmEpD/STamSrSEzt6k/TYnS0TOQrdh0y07It/+L9Ea54EtPlAiZ8inrxb1fD
         TH+Vr7MLpxQZMoVAxKEGFBhKbo/TmkDP64GHFl9jFnkc/1KxZaA2wJkKTPlebbfW34jM
         7qDCfKlMaus4ZUV93s3jRVusr1Gb2dBGtOS5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VVaQL7JBz2O59YUzNrs8XYDcXr6isaO7x07DgRUr02Z9x2OuVrJrwbhnpQZpMDm3aD
         SllcNWsM2ShlETYsIS6EFyGovp95BEm1YzOVLx3PfuHLhIsjHG+iJtjOSttmhkCLus4w
         ATZ7MXO/cdpqw/ZjG+e2PZJKC8G48/q8rKubQ=
Received: by 10.216.88.20 with SMTP id z20mr2202171wee.222.1266963659141; Tue, 
	23 Feb 2010 14:20:59 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002232148470.3980@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140856>

Hi Dscho,

On Tue, Feb 23, 2010 at 3:50 PM, Johannes Schindelin wrote:
> On Tue, 23 Feb 2010, Kirill wrote:
>
>> Unfortunately, it seems to be too aggressive, leading to a misleading
>> display. When gitk is invoked from a subdirectory but without the
>> filter, the lower right panel displays some paths, relative to the root
>> of the work tree, and some, relative to the wd:
>
> Right. I fixed it in 2/3: pathprefix is set to "" when no cmdline_files
> were specified (i.e. when there is no filter). An when pathprefix is "",
> nothing changes to the situation before.
>
> Good?
Seems to work for me. Thank you!

Pat, Paul, like I said, you would not want to take my testing seriously.

--
Kirill.
