From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [ANNOUNCE] codeBeamer MR - Easy ACL for Git
Date: Mon, 23 Nov 2009 21:58:14 +0530
Message-ID: <2e24e5b90911230828h199ae1ccv50d1fbdf50c91296@mail.gmail.com>
References: <4B03B153.1020302@intland.com>
	 <20091118120936.GL17748@machine.or.cz> <4B054D0A.5030802@intland.com>
	 <2e24e5b90911192056t706071ble163a53741017ef@mail.gmail.com>
	 <20091120074702.GW12890@machine.or.cz>
	 <2e24e5b90911210512g5ec26307te63d10912a7906fb@mail.gmail.com>
	 <4B0A5720.6020804@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Intland Software <marketing@intland.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 17:28:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCbm3-0002dS-Hw
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 17:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665AbZKWQ2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 11:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755498AbZKWQ2J
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 11:28:09 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:40033 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933AbZKWQ2I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 11:28:08 -0500
Received: by pzk1 with SMTP id 1so4056565pzk.33
        for <git@vger.kernel.org>; Mon, 23 Nov 2009 08:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=nUir1u5femRPkVyE/Q9liqC+Fz0tNU+7TX8q5KCWgZU=;
        b=sfeUGZaY4Hc37R7o5TFHQugnSRJTB+P36zUqF84cD6UleHi9m/2s/Fhdb6h1qkrF+H
         TYiIy3DewVUWXjG1xN0cwCS0Vab526QhgB2DTt/Qo2dHFg16wUOdPjl7XbFLsPlpMRVN
         2PCKud2OBSApCmeYf60NxgAiDS4PJz9K1SOZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pKpw7Ak9mBUQwUUOmy5Mu2cUU3YquEGDZ6XYcwl9TIqXmHOkijs58Z8bngCsFjNare
         ahYTAV8VC4yrJ9nMehusfuUVi3rIUcjF4hGLnj/l9FvRPMEhneJa9Fvd2+7ESqGzUjRb
         mGjQ2ybo9em9uphbXlxyBNWQVczYoKf2obRjs=
Received: by 10.114.86.11 with SMTP id j11mr9371989wab.73.1258993694592; Mon, 
	23 Nov 2009 08:28:14 -0800 (PST)
In-Reply-To: <4B0A5720.6020804@intland.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133506>

On Mon, Nov 23, 2009 at 3:04 PM, Intland Software <marketing@intland.com> wrote:
> Sitaram Chamarty wrote:
>>
>> Intland: do you have a page that describes your role based ACL stuff a
>> little more?
>
>   This is a good starting point in our Knowledge Base, to read more about
> the permission model used in MR:
>
>   https://codebeamer.com/cb/wiki/11121

Thanks; I've read through that and the link to "Working Sets".

Modulo a bunch of *big* differences [*] in scale and scope between
gitolite and MR, I'm fairly certain that working sets (groups of
projects), user roles, user groups, etc., can all be done using
gitolite's group mechanism and its delegation feature.

It won't be as refined and nuanced as in MR, but in the main,
maintainable access control, which is the main point of all those
features, can be done.

-- 
Sitaram


[*] these big differences are:

  - gitolite config is all in one text file versus whatever MR uses
    internally
  - gitolite only deals with the git repo for each project; MR does with
    all sorts of stuff outside the actual code repo
  - gitolite has no UI for the end user, MR clearly does, and the user
    can do a lot of stuff by themselves (like create new projects)
  - possibly many more I missed
