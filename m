From: Omar Othman <omar.othman@booking.com>
Subject: Re: `git stash pop` UX Problem
Date: Tue, 25 Feb 2014 14:02:29 +0100
Message-ID: <530C9465.3020201@booking.com>
References: <530B0395.5030407@booking.com>	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>	<vpqlhx0a3cb.fsf@anie.imag.fr> <530C893D.7000108@ira.uka.de> <vpqzjlf5q2z.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Holger Hellmuth <hellmuth@ira.uka.de>,
	Brandon McCaig <bamccaig@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 25 14:02:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIHee-0008PX-VM
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 14:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbaBYNCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 08:02:32 -0500
Received: from mail-out7.booking.com ([5.57.20.191]:48388 "EHLO
	mail-out7.booking.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbaBYNCb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 08:02:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=booking.com; s=bk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=ij95uFMUAkLSchCXfOnlzEqzg3FHNy7UbhJx0m+8sP4=;
	b=SEMBa18BdbN0LsLadDwZ05B1kbWOI2aj/0/xmdYmy+PX4SGuhd14avOAI094jV5gAJX8FgtSP329J9IoNIzlO7btE+wbZAbx9sM8Zysu+C7BF5MR8Cl/keRucMfzgndHdli5vLwsXbAGiO/OceJmLHwaGf5oEv4jX6tZmDr/t9Q=;
Received: from corpds-202.lhr4.corp.booking.com ([10.186.68.14]:35775)
	by mtx-203.lhr4.prod.booking.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80.1)
	(envelope-from <omar.othman@booking.com>)
	id 1WIHeX-0008kB-JS; Tue, 25 Feb 2014 14:02:29 +0100
Received: from [10.155.74.57] (port=57776)
	by corpds-202.lhr4.corp.booking.com with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <omar.othman@booking.com>)
	id 1WIHeX-0005mo-Dg; Tue, 25 Feb 2014 14:02:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <vpqzjlf5q2z.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242665>

Well, it's called `git stash` and not `git trash`... :-D

That's your own usage of it, but its main usage is different.

This is not a solution, but it's better than nothing and I second it.

On 25-02-14 13:33, Matthieu Moy wrote:
> Holger Hellmuth <hellmuth@ira.uka.de> writes:
>
>> Am 24.02.2014 17:21, schrieb Matthieu Moy:
>>> $ git add foo.txt
>>> $ git status
>>> On branch master
>>> Changes to be committed:
>>>     (use "git reset HEAD <file>..." to unstage)
>>>
>>>           modified:   foo.txt
>> Maybe status should display a stash count if that count is > 0, as
>> this is part of the state of the repo.
> Maybe it would help some users, but not me for example. My main use of
> "git stash" is a safe replacement for "git reset --hard": when I want to
> discard changes, but keep them safe just in case.
>
> So, my stash count is almost always >0, and I don't want to hear about
> it.
