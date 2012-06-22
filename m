From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFE] option for find branches in a remote repo which contain a
 certain commit
Date: Fri, 22 Jun 2012 17:24:41 +0200
Message-ID: <CACBZZX6nbWCFWWy5NTMSAPOf4RHUAbC9TuffPPy=2Ehn7KSnaA@mail.gmail.com>
References: <CAKkAvazNqZWk=QRmSFsFL33M6z+nZZ_yyxxbxwAh=fQk5DVt-Q@mail.gmail.com>
 <CAKkAvazRfb0kTphLKoRQxSEBZwHfVZeaM0xEbcxEw7Mt5RMg8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: ryenus <ryenus@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 17:25:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si5jS-0005hK-SU
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 17:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762353Ab2FVPZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 11:25:04 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62541 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762296Ab2FVPZD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 11:25:03 -0400
Received: by obbuo13 with SMTP id uo13so2077280obb.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sy3qfc8zwUGbIMW7cMsp1d2XdUDrCIarK4Gsh0HY/oA=;
        b=xAbhHiqe99kXwrpXCvWXcvKzpglM6q7+GgXi1HoVGfzCpL4k5J4uob7T8CzjXrcPgB
         XF0h7S1JTKUIbceszOyU7o3VAtyaUrug2qNBUf9jPyoWbNOuCHJPY8pKzO4opy3owlrW
         OGUsld8z9wbPLxX4g9P16QXOOThTEYNN5iE49D+UoyXSy/DNhFpRcB8izo6flVvjiC3F
         sU+jRuoTJu/v85hxAb49t9B/n3wvRcVLRBKTHHqQJtk+vGeqRDzgeKK+UBYM88IATVyY
         XRyrs4eZP7saP8U6nat6MmK6HvLsd4IDg++5Lko8MWsI0t4d0uZqE0qlFDm2F+vfdwlI
         YGCw==
Received: by 10.182.76.169 with SMTP id l9mr2364175obw.44.1340378702203; Fri,
 22 Jun 2012 08:25:02 -0700 (PDT)
Received: by 10.182.167.65 with HTTP; Fri, 22 Jun 2012 08:24:41 -0700 (PDT)
In-Reply-To: <CAKkAvazRfb0kTphLKoRQxSEBZwHfVZeaM0xEbcxEw7Mt5RMg8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200440>

On Fri, Jun 22, 2012 at 4:58 PM, ryenus <ryenus@gmail.com> wrote:
> Given a certain commit, I want there's a command/option for git to
> make it search the remote repo (e.g. origin) and tell me the
> branches there which contain that commit.

git branch --contains <commit>
git branch -a --contains <commit>
git tag --contains <commit>
