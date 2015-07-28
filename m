From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 04/11] ref-filter: add 'ifexists' atom
Date: Tue, 28 Jul 2015 22:17:40 +0530
Message-ID: <CAOLa=ZQhSEX47LGKAX4AuHqwtE3RKCzpLPJ3xxkiYt3aam0E3Q@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-4-git-send-email-Karthik.188@gmail.com>
 <CA+P7+xq_jC=gE3J=PTkVx8BpTRzCJCfU0V-ydBve2FYbg1gmBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 18:48:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK83H-0002Yg-Sm
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 18:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbbG1QsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 12:48:12 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33891 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbbG1QsK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 12:48:10 -0400
Received: by obre1 with SMTP id e1so88862566obr.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 09:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+EhtCG3/KcEp95WOR9Q5P15C1B5bKC6oYELAhyFqaWA=;
        b=zm0CrHOVuTX1HbqQh2H+QXATWHLQdtlXGHmPSgpxb6vK7liCSfHeYYCDV4BJGHnGmJ
         JdfzzYbTUDPLO83sZaliNr6eR5DIqa8Wkggaqr1h3EipHozKwH6qdIQO43HqjsvdnQfx
         vL+DREpPr4RCrwHQwr9lvaXVtH1L8xSrEjpzkXxieyweyWPiAv5vPpLBtW0aR8Bzi1n4
         Y6hqyb+KwyC6RKu9ABzzd1leuQZvinL7wmWI5OT/akEOOFqFG0NKIRUuEc9PnNi4ccrt
         BY/nsP8zPpHCWs/5OHFOE3LD7jAmTvmWD55N7GwQaepxgT70YD6/zGVT2Yu/e25Dw2cO
         NmMQ==
X-Received: by 10.60.62.105 with SMTP id x9mr34627125oer.1.1438102089861; Tue,
 28 Jul 2015 09:48:09 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Tue, 28 Jul 2015 09:47:40 -0700 (PDT)
In-Reply-To: <CA+P7+xq_jC=gE3J=PTkVx8BpTRzCJCfU0V-ydBve2FYbg1gmBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274791>

On Tue, Jul 28, 2015 at 1:24 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Mon, Jul 27, 2015 at 11:56 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> The 'ifexists' atom allows us to print a required format if the
>> preceeding atom has a value. If the preceeding atom has no value then
>
> Don't you mean "following atom" here? since you do document it as "the
> next atom" below you should fix the commit message as well to match.
> In any respect, this is a useful formatting atom :)
>

That should have been `succeeding` atom. My bad! thanks :)

> %(ifexists:[%s])%(atom) where the contents of atom will be placed into %s?
>
> I suggest documenting that the atom will be placed into the contents
> of ifexists via the %s indicator, as you do show an example but don't
> explicitely say %s is the formatting character.
>

Yeah! I should have explicitly mentioned that, thanks!

-- 
Regards,
Karthik Nayak
