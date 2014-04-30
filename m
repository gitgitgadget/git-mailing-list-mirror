From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Evil
Date: Wed, 30 Apr 2014 13:31:06 -0500
Message-ID: <5361416a172fe_f9b15012ec7e@nysa.notmuch>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
 <xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
 <536106EA.5090204@xiplink.com>
 <536129068cc28_1404fdd310fd@nysa.notmuch>
 <vpqha5akamh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 20:41:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfZRy-0002Z4-OD
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 20:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbaD3Sln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 14:41:43 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:55714 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964997AbaD3Slm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 14:41:42 -0400
Received: by mail-yh0-f50.google.com with SMTP id b6so2075003yha.9
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 11:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Ji42lWTeLoNlc20NsnabFotu+jGAEkWGphBq4DNpfMQ=;
        b=ant3b5e+7ZoBcWuC0WlmlgI/aSLgEp8UrVEQelZ/6hguY0rr9faa75lfu6WdAfJ3L7
         yJk5o0hd5Cs+C7ziGc2I1B/WhQkDu7TdBraZhPloig2JiFJeBA48aRi4KC99GjR2sdpO
         ga16HzyB4l592kDvYw1Y76/xhZz/yhnPkCoDzp45MxHX7Qxrg6L8gIHPi/W6JAKu2axL
         BPmnxK7DWYFDj9aVTu0e5Yxxz9IP9MHpuDbqfibcMEU4rKOOzWJF3emd7mY4EJx08Xon
         4gBYhX/xusgya2dinIpNcYD+bopMW9RqO6fziEC1qgyPuRrg2OamPWAPMvechoURI/wq
         yNMg==
X-Received: by 10.236.163.8 with SMTP id z8mr8280129yhk.43.1398883301810;
        Wed, 30 Apr 2014 11:41:41 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f2sm44284662yhc.41.2014.04.30.11.41.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 11:41:40 -0700 (PDT)
In-Reply-To: <vpqha5akamh.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247756>

Matthieu Moy wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Marc Branchaud wrote:
> >> But I'm definitely biased because I think pull is pretty much broken:
> >> 
> >> * New users are encouraged to use pull, but all too often the default
> >> fetch-then-merge behaviour doesn't match their expectations and they end up
> >> starting threads like this one on the mailing list.
> >
> > Yes, this has been discussed many times in the past, and everyone agrees
> > the default behavior is not correct.
> 
> You definitely have a strange notion of "everyone".

Do I? Let's look at some of the discussions:

http://thread.gmane.org/gmane.comp.version-control.git/225146

* W. Trevor King agrees the default should change
* Junio C Hamano agrees the default should change
* John Keeping agrees the default should change
* Matthieu Moy doesn't agree anything should change
* Linus Torvalds agrees changing the default is fine

http://thread.gmane.org/gmane.comp.version-control.git/233554

* Richard Hansen agrees with my proposal
* Ramkumar Ramachandra agrees with my proposal
* Brian M. Carlson is not happy but can live with my proposal
* Jeff King accepts my proposal is a good way to move forward
* Matthieu Moy is OK with change, but only if the default remains the same

So, by "everyone" I mean everyone but one person (you).

Rational people don't think in absolute terms, "everyone" means
virtually everyone, which is the case.

-- 
Felipe Contreras
