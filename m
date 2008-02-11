From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC] repack vs re-clone
Date: Mon, 11 Feb 2008 20:20:09 +0100
Message-ID: <e5bfff550802111120x24338cd6n6eb1f6db55fe487f@mail.gmail.com>
References: <e5bfff550802100025k616ccff5ib2917d283eeb0ff0@mail.gmail.com>
	 <m3myq7e3ie.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git mailing list" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 20:20:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOeCv-0007DQ-6e
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 20:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755563AbYBKTUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 14:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753645AbYBKTUP
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 14:20:15 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:21569 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbYBKTUN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 14:20:13 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4877986wxd.4
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 11:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2gO2sZUMP9qiRjl/95IbISy/1FGcZnWZZa1ujpMmMRw=;
        b=IwUMTS1EsHaj3bDgYw61axaS9huloAioOCLRt38QutAcCQbWo8481dQxA9KC+wkKumy5OMNjEzHLl3NZd4yTz7jOPiSbwslL3OSrRYy9LE0FyXqEU8FECtoUSSto9LMuJdgVlZKvYFNLme4D6o9pquqwHLHzxx9WGp93neOZ0Ck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s4iLgX0t7Nh+b8e4qPNbBMCfCZGXH8AK6u6ih5BNVE0ctxirO5FDnx7L9D3wybyCuI/ACTFeGAanlx8HxDsI2T7vqEJXV7SBLh/SttnTXwsvYi818zV/gkILUIgzzhh54BA5jQlwG5jPQ256T09h2+Luo1qThEekm45wWVCcyt4=
Received: by 10.140.142.6 with SMTP id p6mr236120rvd.224.1202757609723;
        Mon, 11 Feb 2008 11:20:09 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Mon, 11 Feb 2008 11:20:09 -0800 (PST)
In-Reply-To: <m3myq7e3ie.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73567>

On Feb 11, 2008 7:45 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > So it happens to be just faster to re-clone the whole thing by upstream.
>
> So what you are doing is passing the work, unnecessary work I'd say,
> to some poor server. Not nice.
>

To a poor net bandwidth I would say because cloning from zero just
downloads the packages.
