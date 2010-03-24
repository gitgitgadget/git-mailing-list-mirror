From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Tue, 23 Mar 2010 23:02:15 -0500
Message-ID: <20100324040214.GA8755@progeny.tock>
References: <41f08ee11003212048q1950eb3s95f1caf7ba640874@mail.gmail.com>
 <7vfx3tvv9y.fsf@alter.siamese.dyndns.org>
 <41f08ee11003212134s586aa71cs23255d02f38d53d1@mail.gmail.com>
 <7vhbo8syyf.fsf@alter.siamese.dyndns.org>
 <41f08ee11003220031p6fda651eycff2641df10864da@mail.gmail.com>
 <7v7hp4n6qn.fsf@alter.siamese.dyndns.org>
 <20100322081003.GA26535@progeny.tock>
 <41f08ee11003222301y569a5972q3c67d10c77abe27a@mail.gmail.com>
 <20100323185745.GA1382@progeny.tock>
 <41f08ee11003231939y390ea4cajdb73d09cf2dd6329@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, gitzilla@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 05:02:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuHnY-00064o-DV
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 05:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770Ab0CXECV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Mar 2010 00:02:21 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40183 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab0CXECU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 00:02:20 -0400
Received: by gyg8 with SMTP id 8so3526306gyg.19
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 21:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sApYcPUR+ZXQkjXmfhm9Ii8+btjdOzTjNEKw5LQnPWA=;
        b=rlWz92fEuiYtbkCyrPLGmBaQsP3BQJ5fE5PG/4YWa0NnAZ91G2jhpFFNctQ3DcnYv0
         nbIBZ26GWdceOLwRXeFdpj/JiojwR96otGjb2QQm38nSDeQbpUeILOieiYN9ahRmA6tF
         qCF7jXU+/+P+odi5yZQcTh/azJ74caXt30UtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=omrb2mTivLKKlEqwWsZMts1KYh1So7hqFbQdH7SnRVcJh2SSmKuBxFgxIaRNuRYnlD
         Y7RLa+DSlwgNFjwhOPERQclTrYqrMgGpnjwLp0FbZ3+sLtlCPmeFLIT2VGtIPFwzHnpV
         Be7++V6UsRzLuuYedews0ATQxs88atU15SpeE=
Received: by 10.150.168.32 with SMTP id q32mr6494911ybe.88.1269403337114;
        Tue, 23 Mar 2010 21:02:17 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm5645753iwn.11.2010.03.23.21.02.15
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Mar 2010 21:02:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <41f08ee11003231939y390ea4cajdb73d09cf2dd6329@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143066>

Bo Yang wrote:
> On Wed, Mar 24, 2010 at 2:57 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> I am not actually sure, but I assume =E2=80=9Ctrue pickaxe=E2=80=9D =
refers to the
>> goals described in <http://gitster.livejournal.com/35628.html>
>> and the linked-to message.
>
> I have looked over the article and the message from Linus, it really
> help me very much.

Okay, so now I looked over that thread again.  I found this [1]:

  <http://minnie.tuhs.org/Programs/Ctcompare/index.html>

It=E2=80=99s for fuzzy matching of a certain kind.  The latest version =
is under
the GPLv3, unfortunately for us.  I would still like to reiterate my
warning to not get sidetracked on this, but maybe it would be pleasant
reading.

Enjoy,
Jonathan

[1] Thanks, Linus.
http://thread.gmane.org/gmane.comp.version-control.git/27/focus=3D225
