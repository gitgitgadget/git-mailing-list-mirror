From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] Add support for merging from upstream by default.
Date: Mon, 7 Feb 2011 10:43:55 +0100
Message-ID: <AANLkTim7hRrGtT_9dsHWp-405H_RF1s=UUQ6BPFCOY+n@mail.gmail.com>
References: <m2k4he23z6.fsf@whitebox.home>
	<1296912681-4161-1-git-send-email-jaredhance@gmail.com>
	<AANLkTikii-fx5nYeBDc70eh_wj05sEZ6fH6=bF9GqHBK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 10:44:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmNda-0002NY-GN
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 10:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979Ab1BGJn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 04:43:57 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45161 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab1BGJn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 04:43:56 -0500
Received: by wyb28 with SMTP id 28so4336325wyb.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 01:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/yeJTSldLsYBG8odx8gGekCGF6TkS+i06ukIpBl220Y=;
        b=h21geBvQMDwMw4Q+BlNbdX4FdIw+umuBmD3ni85PNxFt37TEhvPN58hqL0KSUWrFqw
         4wbuELwoZokon0RyoYuFwYeQ3zpBczGu7ZRqNQ4OwBm6ACErDo+j7+K3/Bu7vP6UjXtY
         6JqKq4S11Jdqxrg1vgIRadI2bPjADaO/+R0IE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=OWeYyABIdJEWrzWVK91nZq2YmEYYhCTuVMEBWx1/oD2OXi4/DNHoy2R6Gw2L3HBfTA
         aVlTjXOGiWTpzQJZTY6Ur6lHMzHcehuDDKEQvxW1bOHFN7L1IPbiztpknIIT9774ykaC
         TAlJPJDFz+Huz96Pgklyg7CAJ0es18MAtjjuY=
Received: by 10.227.152.197 with SMTP id h5mr2438615wbw.78.1297071835511; Mon,
 07 Feb 2011 01:43:55 -0800 (PST)
Received: by 10.227.129.18 with HTTP; Mon, 7 Feb 2011 01:43:55 -0800 (PST)
In-Reply-To: <AANLkTikii-fx5nYeBDc70eh_wj05sEZ6fH6=bF9GqHBK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166246>

On Mon, Feb 7, 2011 at 10:36, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> On Sat, Feb 5, 2011 at 14:31, Jared Hance <jaredhance@gmail.com> wrote:
>> Adds the option merge.defaultupstream to add support for merging from the
>> upstream branch by default. The upstream branch is found using
>> branch.[name].upstream.
>
> Why do we need a per branch config for this, isn't .origin/.merge

Why do we need a *new* per branch config for this, isn't .origin/.merge

> enough? Or, where is the connection between your new .upstream and the
> @{upstream} ref?
>
> Bert
>
