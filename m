From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: In search of a version control system
Date: Sun, 21 Oct 2012 20:16:50 +0700
Message-ID: <CACsJy8ASoaH40ScHwv1EB2kw8sxMh3oFb45s5shUPUmRUF7gRA@mail.gmail.com>
References: <1349719581.76671.YahooMailNeo@web122505.mail.ne1.yahoo.com>
 <CALkWK0kCbLxPMbxh=CLAE8UkkNFNqDa1QbtdM_-Q+Qr3SRh46Q@mail.gmail.com>
 <vpqa9vwstp3.fsf@grenoble-inp.fr> <CAJDDKr5PxM3a6TjfdVoCp1VzgCFBKQ6YGhpN-BO-D=CyVTQX3w@mail.gmail.com>
 <vpq4nm4rxsy.fsf@grenoble-inp.fr> <CAM9Z-nnQjhehJEpyhyTY=rsK_f=2gTOUMVTycn7-Lao8Gog0pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	David Aguilar <davvid@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Maurice Francois <francoismaurice2001@yahoo.ca>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 15:23:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPvV4-00064P-I4
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 15:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766Ab2JUNRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 09:17:25 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:59136 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab2JUNRY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 09:17:24 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1690094oag.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=14uQnfZKkhH1D5iEsxCXAmXDlELZ8b91rODydvrSiS4=;
        b=Y9EvyJRgcxOFsEV4fVadBFJtXnpcIKJ1C/WJXAzgc8o24JSOwLtYs8Ksq/BP2grjVV
         1tKUZ8n0s6ghRHPUJHnuvdWZy7LvDOj8A05lSdZNsLfZw503vZkMwZFhJVYFnICbYmld
         RjBNkIZ3c9IrFljS3CutVrRi9KtGSvBDJN+WHrWwCbP2CmfnKWqFJfbtGmDGwx2WBrPa
         s7rU96hc6PAV+/P/2ipXsU3JM1DHBRvvXf8cRH8+2Z6DCXCzj2+BlMbnY364v6u+u9Jh
         wi5XHT4b8Ak4sAGHWs9BOQ4Z5rbEtQt68hiq6C+WpkeKnUrLtVhGz/BXE7yhQuq7hzbv
         v+Iw==
Received: by 10.60.23.195 with SMTP id o3mr5791917oef.14.1350825441869; Sun,
 21 Oct 2012 06:17:21 -0700 (PDT)
Received: by 10.182.108.10 with HTTP; Sun, 21 Oct 2012 06:16:50 -0700 (PDT)
In-Reply-To: <CAM9Z-nnQjhehJEpyhyTY=rsK_f=2gTOUMVTycn7-Lao8Gog0pA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208124>

On Sun, Oct 21, 2012 at 7:20 PM, Drew Northup <n1xim.email@gmail.com> wrote:
> On Tue, Oct 9, 2012 at 1:58 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> David Aguilar <davvid@gmail.com> writes:
>>
>>> I would advise against the file locking, though. You ain't gonna need
>>> it ;-)
>>
>> What do you suggest to merge Word files?
>
> If the files are in the DOCX format you can just expand them as zip
> archives and diff what's inside of them. The text in particular is
> stored as XML.

An XML diff means nothing to a regular user, and manually "merging"
this way can produce unreadable Words files. So no, it's still not an
answer.
-- 
Duy
