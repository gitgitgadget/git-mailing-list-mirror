From: Stefan Beller <sbeller@google.com>
Subject: Re: 0 bot for Git
Date: Tue, 12 Apr 2016 07:59:46 -0700
Message-ID: <CAGZ79kZzdioQRFEmgTGOOdLQ-Ov-tWmgi1dLhHPDVzDb+Py2RQ@mail.gmail.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
	<CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
	<CACsJy8DiCw_yZNp7st-qVA7zYEHww=ae5Q=uKVzBhAfU8akR7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 12 16:59:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apznD-0000VR-SC
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 16:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbcDLO7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 10:59:48 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38788 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964873AbcDLO7r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 10:59:47 -0400
Received: by mail-ig0-f180.google.com with SMTP id ui10so23445636igc.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to;
        bh=otccbRDvmgVccYSxF1nE6zarKFTR8T9A5/y0RF8s78Y=;
        b=Ui5GHJwhfB7KnAfoLhPi1MpGbe3n57P7E3PzPe3Paprs1bL2jR9RoHHbqXO+YvHnWd
         4NmV3hMH15N3ylbGb01fBjfdsFT4fPoxrcOeNYk51ZqgGjZfWdoNmVEY/k4FVqbgBf3o
         ghlKzuQAnd3E+SIPv8+QFsnhvyFlWHEvncbd4O4VUeT7nkN5RtaFltHH2Q+ZkAb4uBPy
         lUBfMAkKWm94DRsyy2uPzVYRGZMunGLpADtAgA3bXF/eTIVJ+BD8/vqfIbkvgenlI8VB
         0PpCIv78MJHUn9nqnltkRVicmaIhSV0S8uCMK90NBNrAsUbirOtY7rl9mzBXan8WkRxi
         tORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to;
        bh=otccbRDvmgVccYSxF1nE6zarKFTR8T9A5/y0RF8s78Y=;
        b=jImFtoMzkoKYAwrZ+1UtT6+NpZY5zTD0r8zH0aRwfDYcU/pD5A1W8HgR1LcIBLFfUW
         OzqX+KDJyWqg/Z/LhlI1lRlpEJpSxnOWwgip/cVfQ/Sl14uPJtKyKO8WmeRuabOvE3Iq
         OMlyTGfIy8CGv1xl8qu5CENSwnY5a0/ioky417yosxjRyc2+dzzeQS4+XArerKN/cqvE
         361iW/Xz/U5QQ/y8xXwcC0ChovG9Vzfc++sCu45YXDkW0XSBPdm0nHf5gtCWkH9B5KNr
         aEbr9YYPW84ADhfcHLnfuAdplgybDP4YxKFNDqPHiElpVFFE9T5QooGhC0AG5OpEZWkU
         1SKQ==
X-Gm-Message-State: AD7BkJI3sBoa4cfLozjOPkdxA7BVWSix97MqxO2XEHp0FtS4rHF6TApxKxBMkSsVUD8EepWdKuo3keIxZOat6iqi
X-Received: by 10.50.23.80 with SMTP id k16mr26147943igf.94.1460473186184;
 Tue, 12 Apr 2016 07:59:46 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Tue, 12 Apr 2016 07:59:46 -0700 (PDT)
In-Reply-To: <CACsJy8DiCw_yZNp7st-qVA7zYEHww=ae5Q=uKVzBhAfU8akR7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291265>

On Tue, Apr 12, 2016 at 2:42 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Mon, Apr 11, 2016 at 7:51 AM, Stefan Beller <sbeller@google.com> wrote:
>>> Hi Greg,
>>>
>>> Thanks for your talk at the Git Merge 2016!
>
> Huh? It already happened?? Any interesting summary to share with us?

Summary from the contributors summit:
* encoding was a huge discussion point:
  If you use Git on a case sensitive file system, you may have
  branches "foo" and "FOO" and it just works. Once you switch over
  to another file system this may break horribly.

  The discussion revealed lots more of these points in Git and then a
  discussion on fundamentals sparked, on whether we want to go by the lowest
  common denominator or treat any system special or have it as is, but less
  broken.

* We still don't know how to handle large repositories
  (I am working on submodules but that is too vague and not solving
  the actual problem, people really want there
    * large files
    * large trees
   [* lots of commits (i.e. lots of objects)]
   in one repo and it should work just as fast.)

That was my main take away.

Stefan

> --
> Duy
