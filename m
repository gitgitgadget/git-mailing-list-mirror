From: Blind <stoycho.sleptsov@gmail.com>
Subject: Re: [RFC/PATCH] Introduce branch.<name>.pushremote
Date: Tue, 19 Feb 2013 13:51:33 +0200
Message-ID: <CAGL0X-ocNDea_iRB8-ZjoSXqSkXn-V9F1Tz51GgpzqtLdg5t5Q@mail.gmail.com>
References: <1360307982-20027-1-git-send-email-artagnon@gmail.com>
	<CAGL0X-rKnWBy-Ff=YmEdqgo8RFb40FXTxvUM5X77YaQvhAGHYg@mail.gmail.com>
	<CALkWK0kBjsHtK1_7imJx-7CATSKFzpUgGzH6Hs9DAQ8c7jRUPw@mail.gmail.com>
	<CAGL0X-qLikj3bKervpASEixnEVLjBGDN=8QX8K6SG-A2Z_dVUg@mail.gmail.com>
	<CALkWK0nJbbA_wjo--LW9v7pP35LS4SUOhZjHVh4dbZqDjSJnew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 12:51:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7ljq-00068X-J9
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 12:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460Ab3BSLvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 06:51:35 -0500
Received: from mail-ve0-f171.google.com ([209.85.128.171]:54153 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932202Ab3BSLve (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 06:51:34 -0500
Received: by mail-ve0-f171.google.com with SMTP id b10so5706564vea.2
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 03:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=QBu9JqEwhxe19kiZHrMgVa3G/IoTlyzod6qIc5zbdfc=;
        b=UGSoDHInmQqtxIRzl4AWthqDCLwfXTEW4jNESYYJn47mrY3GrTOd/aHWOGWwhWm6BR
         1raLEDvfKlf/HhLtIOvikGDd2iqaYj4QPBkXCUcvkERTv63ABK2YnsT77LYQjC6asHuM
         sC2xhDHenuWiZyV6eOjZmQwtadBfn/QqM7zibx22JBtzIr3vQZRuG7rP+2kpEyOAmg23
         Yhf0c61R1oxdUia9UisK/JyBuy73yOnJeEXvrR8skczN2tt2YdhEdcOmuH42fASqjcmN
         e6AGNEAdz262p3MnHD42dEMQUrQrBPeZ+H2nnEGycdkAj9PG7sRxkFLe0F15PyyvHXny
         YUJg==
X-Received: by 10.52.175.66 with SMTP id by2mr18104795vdc.53.1361274693553;
 Tue, 19 Feb 2013 03:51:33 -0800 (PST)
Received: by 10.58.55.228 with HTTP; Tue, 19 Feb 2013 03:51:33 -0800 (PST)
In-Reply-To: <CALkWK0nJbbA_wjo--LW9v7pP35LS4SUOhZjHVh4dbZqDjSJnew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216608>

2013/2/19 Ramkumar Ramachandra:
>
> What is your usecase?  If you have a local branch with the same name
> as on the remote, why wouldn't you want to push-to-update it when you
> make changes in the branch?  In other words, why doesn't push.default
> = matching suffice for most practical purposes.
>
>> ... or branch.<name>.pushremote can support some kind of a "none" value?
>
> Not a bad idea at all, provided you tell me your usecase.

The question is infact about branches who are not on the remote.
push.default=matching wouldn't upload the branches which are not there already.
push --all on other hand pushes .. all (as expected :-))...

Its difficult for me to manage quickly, lets say, "news-to-push/*" and
"crazy-ideas/*" branches ...

Blind.
