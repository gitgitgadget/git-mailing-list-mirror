From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Thu, 20 Jan 2011 19:32:40 +0200
Message-ID: <AANLkTikvVaSTV8hVjDXLvOEEDv5qr19ybk3Cm--+bgWA@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org>
	<ih95fg$62b$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 18:33:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfyO7-0003il-7r
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 18:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003Ab1ATRd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 12:33:29 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40677 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988Ab1ATRd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 12:33:28 -0500
Received: by bwz15 with SMTP id 15so770830bwz.19
        for <git@vger.kernel.org>; Thu, 20 Jan 2011 09:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=MnyVP6cfLmVOAm0KQ6DCZvs6vsddMTpzZ5q/IqI/WF0=;
        b=owr7sbOktB8L3Gk3sP17zDj6DjC62xAOXWLqcGoj7B6ps3WLtTcHkOFqkuma2FDgQn
         gPlIpGJ9PGugwaFRX4lC8mV0KR1MxHbA/NQ3lp3yGn/gDi6zlnsRngpyz6Z83acvARZa
         0A2ktNvbUM2amO4xwLVsFfYgDmBQM0E9ARqmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XPA3OiaRkvZjTsIyZ36MMc2LhiJ/9iVAAvF/M7FzMLS4pnc2LAR2pQlHBDn00CQqN5
         OtLhidaNqyJSoE5aVIF/6jYKhTmyFf4hpnvhgCX/v2Xk1HxHqS43U8pWTDVyAis0KTTU
         2LroHAPz4DPvYu9MlJM4HT8S2754BZ9FRmtus=
Received: by 10.204.33.74 with SMTP id g10mr79366bkd.131.1295544760778; Thu,
 20 Jan 2011 09:32:40 -0800 (PST)
Received: by 10.204.157.4 with HTTP; Thu, 20 Jan 2011 09:32:40 -0800 (PST)
In-Reply-To: <ih95fg$62b$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165320>

Hi,

On Thu, Jan 20, 2011 at 1:14 PM, Stephen Kelly <steveire@gmail.com> wrote:
> Stephen Kelly wrote:
>> On Friday we had an issue where a developer pushed a branch called HEAD to
>> the remote server. The result was that other developers could not pull or
>> push.
>
> Does anyone have any thoughts/response on this?

Can you list a series of steps to reproduce this?

> Why does git not have a bug tracker?

Because it's not needed. If you have an issue, post the issue as you
would file a bug:
 Which version of git?
 Which kind of network transport was used?
 Is this reproducible?

Chances are, if this is reproducible in the latest version, someone
would fix it soon enough. If not, and it's important to you, you would
ping back. If other people find this issue, they would send another
email.

In fact, if you really want to help, you could clone the latest
'master' to see if this still happening, narrow down the steps needed
to reproduce this, write a test to trigger it and send a patch.
Certainly, a test case that constantly fails would be a constant
remainder that there is a bug.

Cheers.

-- 
Felipe Contreras
