From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: Fetching a single file from remote repo
Date: Mon, 13 Aug 2007 15:38:27 -0700
Message-ID: <a1bbc6950708131538n364f6a82l34b00baa1d751d48@mail.gmail.com>
References: <a1bbc6950708131131q74525060x85d5e31c6a538f76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 14 00:38:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKiYY-0000mO-Nm
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 00:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933483AbXHMWie (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 18:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933441AbXHMWid
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 18:38:33 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:59930 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932981AbXHMWia (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 18:38:30 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1284617rvb
        for <git@vger.kernel.org>; Mon, 13 Aug 2007 15:38:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dY59+QgiMpUo6vP0gKg++vBTgqp4ngUSMZE5ZGZD0wgBDTPhmxuo4KC+3ulzPbqXTnYZbi2dQIUUaULowrdym/9+oEOCOaFMwLIpE4zWRU8us1Y8Ib5fPbqgYxezLcs1Eqp6GduYgl301bjuQP1mPJ0MNweJrE9IV9mBnEsHr2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QW+yd8zP7rTxgBfxNRgrRGDJfhEsgePU61xMC+rHpnVRaN5hQo5CTVDBda37rbNylZmke7AVP2vq4y0Q3UFiBX60y8KLhkVFPTevam8kxGyiSybtiuFrhat0PnrPkj4CtePfIgZlv71lVe2CnUjhuw8Ffr/8mA00qW5lt6HvYB4=
Received: by 10.141.164.10 with SMTP id r10mr2736769rvo.1187044707723;
        Mon, 13 Aug 2007 15:38:27 -0700 (PDT)
Received: by 10.141.21.17 with HTTP; Mon, 13 Aug 2007 15:38:27 -0700 (PDT)
In-Reply-To: <a1bbc6950708131131q74525060x85d5e31c6a538f76@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55793>

On 8/13/07, Dmitry Kakurin <dmitry.kakurin@gmail.com> wrote:
> Is there a way to fetch a single file from remote repo without
> creating a client repo?
> I want to do something like
>  git show --repo git://repo.or.cz/bla.git master:/somedir/file.txt

I think I have found it:
git archive --remote=http://62.24.64.27/r/msysgit.git
master:share/GitMe setup-msysgit.sh | tar -x

-- 
- Dmitry
