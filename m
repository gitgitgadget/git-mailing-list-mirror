From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Test failure: Test #3 in t1304-default-acl
Date: Mon, 17 Sep 2012 08:32:56 -0700
Message-ID: <CALkWK0=cDW7BU6QofaeLbtETwzrnWBuuKcpgYNaM1x5tutisfA@mail.gmail.com>
References: <CALkWK0n0bH3xPLarv35Th_agnhKCkRjgcKTJR7Xy=B_NkBHkOg@mail.gmail.com>
 <vpqy5k8raig.fsf@grenoble-inp.fr> <CALkWK0=h6iU_J=X6MFgLXPfo0rh236cTuVaU3nNSnAaikjKH5w@mail.gmail.com>
 <m2txuw1xcj.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 17:33:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDdK9-0005BI-W5
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 17:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132Ab2IQPdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 11:33:18 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:39208 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932073Ab2IQPdR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2012 11:33:17 -0400
Received: by qcro28 with SMTP id o28so4560250qcr.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 08:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=oK3rY4fhe4icDsZ92j1D5zfVw4PcHeZkW2OyB1hDHbc=;
        b=GogmyYEVLczZXbsKyLat11Sy8i59ZezQipFyVN1IuHkIeP3FZMZ3A22/ScZo/8ZsWM
         bCMqVoNincZrc3bnNTctsXuq6Nh6nOafzOpEkzjCDCsrdqBkAx6HJahoj+cMeyH9yHZP
         yPOfGsxY+KIyuxmXESGa4S1IsS20ZMKYDPq6QCKwXWtaOJQAgmtRl21Bie/pVjp71Od6
         Y1iNMeEIy0bQMo7iVHmAsZ9CnPE6BBcKwA6ThgPznEbTCxzOfRQ73auRofKTOYRZ0l5y
         livV2XieTN1nBrvhEHs1HkNImaehbYKQz6W8pe3PPTuNnDWjIIUXi0filboOKyouUpJA
         QDvg==
Received: by 10.224.58.147 with SMTP id g19mr28172127qah.77.1347895996410;
 Mon, 17 Sep 2012 08:33:16 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Mon, 17 Sep 2012 08:32:56 -0700 (PDT)
In-Reply-To: <m2txuw1xcj.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205702>

Hi Andreas,

Andreas Schwab wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Hi Matthieu,
>>
>> Matthieu Moy wrote:
>>> Do you have any user with this login (finger kseygold)? I suspect you
>>> have two usernames with the same user ID.
>>
>> Login: kseygold                         Name: Seybold
>
> What about "id kseygold; id ramkum"?

Apart from the UIDs matching, what do you find interesting about the output?

uid=1420023794(kseygold) gid=1419772417(domain^users)
groups=1419772417(domain^users),1419841836(sw-xchat-irc-client),1419932703(gref-sp-visitors),1419997311(fs-dus2-training-public),1420238821(sw-amazon-cloud-uploader),1419880095(dfs-pcsoft),1419980124(cs-psc-users),1419988839(scmdmauthorizedusers^(amzn-mdm)),1420131555(fs-lej1-oe-extern),1420053059(wireless-corporatewifi-allow),1419965136(sw-ms-ie7),1419812553(opr-pcsoft),1419806474(mac-caspershare-access),1419852490(dcolnl-accessrequestor),1419852491(dcolnl-visitorpre-registrationrequestor)
uid=1420023794(ramkum) gid=1419772417(domain^users)
groups=1419772417(domain^users),4(adm),20(dialout),24(cdrom),46(plugdev),116(lpadmin),118(admin),125(sambashare),1419841836(sw-xchat-irc-client),1419932703(gref-sp-visitors),1419997311(fs-dus2-training-public),1420238821(sw-amazon-cloud-uploader),1419992049(fhrix-employees),1419880095(dfs-pcsoft),1419988839(scmdmauthorizedusers^(amzn-mdm)),1420131555(fs-lej1-oe-extern),1420053059(wireless-corporatewifi-allow),1419812553(opr-pcsoft),1419806474(mac-caspershare-access),1419852490(dcolnl-accessrequestor),1419852491(dcolnl-visitorpre-registrationrequestor)

Ram
