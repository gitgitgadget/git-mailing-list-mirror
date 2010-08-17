From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] t/t5800: skip if python version is older than 2.5
Date: Tue, 17 Aug 2010 18:28:38 -0500
Message-ID: <20100817232838.GH2221@burratino>
References: <AANLkTinQrdJeTxoZ207kvv5R_3qUj5ocGgAlC22SQyOg@mail.gmail.com>
 <injaoVtrfs7Li4aYBNxEQeawf3YbhxcYbL79Jvef2ML9502YRtjqEol2RVKBzXfH_PfbMep0lvU@cipher.nrlssc.navy.mil>
 <AANLkTimwNBAKwhKwsquDS4k3x0_iDo3rEyqFfhMcsb38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	gitster@pobox.com, Brandon Casey <drafnel@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 01:30:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlVbw-00008B-Ua
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 01:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041Ab0HQXaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 19:30:21 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59532 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab0HQXaU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 19:30:20 -0400
Received: by vws3 with SMTP id 3so5134851vws.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 16:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uimnfEWnFegSj+93Yu8MOUxwsjLpdQ8ntN01RFC9mLc=;
        b=Sm+QcT8vCfaUGyxnM4O3ZbbI1FG3dI/J315u0E0Hatav15zy9ayvTxxv48NRU7zv23
         tIsC5MaImhjxgYyIAYbZbv37EOq8qeri4lp5RMwh1RxU37Tt5KOMSJDo28ATKeItBO1b
         Zj8rUXFmm601tB9DKxs/ah3Vg8eu/Kd99f8sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gHn79RYQssqCvpUt//vPIMcmy/U48TtQHfqmSd0wfyYMkPboKpB5uo6j9tZadXt8Sb
         Zcs63zm1e0Svq2e4BwPImD/0dAl+c55WLli/C9Qd9ZBdyLroo9ueoxmBMFvJ7Z5wFxiV
         lxN0AOcMmi0/WTaYc/gx/omlMpdT5H8jMQZH8=
Received: by 10.220.124.198 with SMTP id v6mr4387770vcr.27.1282087819752;
        Tue, 17 Aug 2010 16:30:19 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id m30sm4610395vbr.9.2010.08.17.16.30.18
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 16:30:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimwNBAKwhKwsquDS4k3x0_iDo3rEyqFfhMcsb38@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153789>

Sverre Rabbelier wrote:

> sverre@laptop-sverre:~/code/git/t$ make t5800-remote-helpers.sh
> *** t5800-remote-helpers.sh ***
> t5800-remote-helpers.sh: line 10: : command not found
> * skipping git remote-testgit tests: requires Python 2.5 or newer
> * passed all 0 test(s)
> 
> I'm not sure what is wrong here, but somehow the PYTHON_PATH variable
> is not propagated to the script?

Hmm, what does your GIT-BUILD-OPTIONS say?
