From: "Ciprian Dorin Craciun" <ciprian.craciun@gmail.com>
Subject: Re: Repository specific git commands
Date: Mon, 7 Jan 2008 15:14:39 +0200
Message-ID: <8e04b5820801070514l7a49b0fewcaa5f4b6d9a6c622@mail.gmail.com>
References: <8e04b5820801070415j5166c2eco53760cffe1ab1efb@mail.gmail.com>
	 <Pine.LNX.4.64.0801071352470.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 07 14:15:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBrpB-0007Ch-TH
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 14:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755716AbYAGNOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 08:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755914AbYAGNOl
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 08:14:41 -0500
Received: from hs-out-0708.google.com ([64.233.178.242]:22603 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755716AbYAGNOj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 08:14:39 -0500
Received: by hs-out-2122.google.com with SMTP id 54so5257985hsz.5
        for <git@vger.kernel.org>; Mon, 07 Jan 2008 05:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lywALcLKhazwVaf24HT0Y/5efvYSvZ59R0o8tnEGh08=;
        b=QX+72F0G8TAOytIjatAQM2zchCzm9qMeZmNerVTNuOjdDvcbbkYtR8ZUNn3l6Kf1OKUfX9URjMfNsl54mLkYrJN7AoWqZ22RtmZgeRvtI2UXizTA1CkIUsWXLNgeM9Q/fjBCIn7BAEcOkO07ulRsk53pK4h7IskoCP3JjFIV0Rg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FL0sF2BPWAqcsDuzHEG5xwTNrUSxu3wQAoTTTHQIPP6a6PHYVG+nR9J0hKT4YBjmwmC22E3SCxc895m7eRrQ2n6W3mTjfP+Bu/FO1sZLdGMeFaF7rK70kD4gm9+sOVG2w/NgwrNRsWkQHPs+0u6dF01OAzT3ga2YCg9+Cvv77W0=
Received: by 10.150.158.8 with SMTP id g8mr1357126ybe.94.1199711679075;
        Mon, 07 Jan 2008 05:14:39 -0800 (PST)
Received: by 10.150.11.9 with HTTP; Mon, 7 Jan 2008 05:14:39 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0801071352470.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69790>

On 1/7/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 7 Jan 2008, Ciprian Dorin Craciun wrote:
>
> >     -- either define an alias -- but usually it is very restrictive in
> > terms of what the alias can do;
>
> You probably missed the possibility of executing a shell command (or
> commands) viathe  "!" prefix.
>
> See also
>
>         http://git.or.cz/gitwiki/Aliases/
>
> Hth,
> Dscho

    I knew about the "!" prefix but this allows me to write only a
one-line script... But in the case I want more complex scripts? (Just
look at how hard it is to read the "Getting the diff of only one
function" example...) (Yes I could create a script, place it in a
special folder and add an alias to it -- remembering to put the right
path... But it is not as simple as adding it to the bin directory.)

    Ciprian.
