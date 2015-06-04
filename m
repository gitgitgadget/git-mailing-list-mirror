From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC] send-email aliases when editing patches or using --xx-cmd
Date: Thu, 4 Jun 2015 17:24:46 -0400
Message-ID: <CAPig+cQbOnaNg8dkbFoRrUN47oEAxUNjRXhMK1HSgCLi6ZxHyQ@mail.gmail.com>
References: <87pp5b1b4g.fsf@ensimag.grenoble-inp.fr>
	<CAGZ79ka89omT3wKqV-J4eyAz+xDXDS+OBcXDDFsO=4kk1HBBpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>,
	Allen Hubbe <allenbh@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 23:24:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0cdA-0006Xt-AA
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 23:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbbFDVYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 17:24:48 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33211 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbbFDVYr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 17:24:47 -0400
Received: by igbpi8 with SMTP id pi8so1724631igb.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 14:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=W7Q3Diglgpu005yY7Suv++Ztu0Cp3V+jJDVGnHiISMc=;
        b=UnVSw8XGhv7Qb7CVKlyQ2zN3bHxCXLrBhFWfaw6fN1iOOi677FrjJsl6b1DRkqORVi
         FJQ0jSeBQYHWQ+rAmxGQ2tfsaZvhiSlS3oFZBBxrV1kpe4YjMc0y1meVTKvqdflHvkOy
         IBPeJEz29YhsBFLkatYN87S+aADg1rdSxpSszeUKTl9+XL6OQ9LrmWO9KI9gp1UzBKum
         RUCuProkTbbXRRs8c+q5fASDSMOWpJUOoEuZM8DbOJQWnUGNNvD0YuV9AHyRKUJMLeWO
         C/oykWIDghu2P4jw4ml359XFlKvQmIgs2J14n1pkEUmxfvHbWxE1EalhzTc7VjO7rgDP
         AUtw==
X-Received: by 10.42.146.202 with SMTP id k10mr6806343icv.34.1433453086842;
 Thu, 04 Jun 2015 14:24:46 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 4 Jun 2015 14:24:46 -0700 (PDT)
In-Reply-To: <CAGZ79ka89omT3wKqV-J4eyAz+xDXDS+OBcXDDFsO=4kk1HBBpQ@mail.gmail.com>
X-Google-Sender-Auth: q7phbFe9L14PwOP9jY4ZOFIYtJc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270799>

On Thu, Jun 4, 2015 at 5:11 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Jun 4, 2015 at 1:17 PM, Remi LESPINET
> <remi.lespinet@ensimag.grenoble-inp.fr> wrote:
>> Working on git-send-email, I've seen that there's no aliases support
>> when manually adding a recipient in a 'To' or 'Cc' field in a patch
>> and for the --to-cmd and --cc-cmd.
>>
>> I would like to add this support, and I wonder if there are reasons
>> not to do it.
>
> Just recently Allen Hubbe did work on alias support,
> I did not follow that topic though.

Allen's patch added support for another aliases format file but is
unrelated to Remi's proposal and would not conflict with it.
