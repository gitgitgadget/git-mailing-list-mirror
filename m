From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Re: Git with Lader logic
Date: Wed, 18 Mar 2015 17:28:45 -0500
Message-ID: <CAEtYS8R6xz3vMD72h_j0R6W=FRfY7SjMi-q9z+qfKhqoq5ExCg@mail.gmail.com>
References: <5F9B9EBF-CD4D-42A8-8A0C-9806702231A1@icloud.com>
	<00bd01d061b5$331874c0$99495e40$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bharat Suvarna <bharat.bs84@icloud.com>,
	Git List <git@vger.kernel.org>
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 23:28:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYMSJ-00051w-QO
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 23:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbbCRW2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 18:28:47 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33313 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbbCRW2q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 18:28:46 -0400
Received: by lbnq5 with SMTP id q5so12209989lbn.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 15:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bc7mtM8UBLYDno6TESPEp+WDfyf9KqYYzCQ61IaP/XI=;
        b=mrMkMTsvcslUD5MIK0+lhctxpP0HTB2vl/sd29Bj9OwoqFFX4OnDtaYC40Go+fpnBE
         I4ShCSfckme+nOAr+X36opqjAC92TLSrPdpyaJUEFX1gB8xNnTkMHRDWDwi4I7CjkGAn
         leXmG3obq2o7b66jJZUM1JzneWYs8sQzJ3RpbjTVjfFFwOK+WapWB0ghvIB63hJSdAYz
         60rDBBnPCnjQ5EROZL1oO7tF+6EIYzsqGdlcMoRaVCQ8JxSPzeQ7nIldFuszcRvI59Qj
         cfWbA4vaXNJTg4lGuPw9PEQ0RGx6rS/7gtZIjbNmCLJx5qBmRpvYyIeYssH8Fy/6kvMx
         TmsQ==
X-Received: by 10.112.89.71 with SMTP id bm7mr38744189lbb.20.1426717725221;
 Wed, 18 Mar 2015 15:28:45 -0700 (PDT)
Received: by 10.25.81.145 with HTTP; Wed, 18 Mar 2015 15:28:45 -0700 (PDT)
In-Reply-To: <00bd01d061b5$331874c0$99495e40$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265768>

On Wed, Mar 18, 2015 at 2:53 PM, Randall S. Becker
<rsbecker@nexbridge.com> wrote:
> On March 17, 2015 7:34 PM, Bharat Suvarna wrote:
>> I am trying to find a way of using version control on PLC programmers like
> Allen
>> Bradley PLC. I can't find a way of this.
>>
>> Could you please give me an idea if it will work with Plc programs. Which
> are
>> basically Ladder logic.
>
> Many PLC programs either store their project code in XML, L5K or L5X (for
> example), TXT, CSV, or some other text format or can import and export to
> text forms. If you have a directory structure that represents your project,
> and the file formats have reasonable line separators so that diffs can be
> done easily, git very likely would work out for you. You do not have to have
> the local .git repository in the same directory as your working area if your
> tool has issues with that or .gitignore. You may want to use a GUI client to
> manage your local repository and handle the commit/push/pull/merge/rebase
> functions as I expect whatever PLC system you are using does not have git
> built-in.
>
> To store binary PLC data natively, which some tools use, I expect that those
> who are better at git-conjuring than I, could provide guidance on how to
> automate binary diffs for your tool's particular file format.

The one thing I find interesting about RSLogix in general (caveat: I
only have very limited experience with RSLogix 500 / 5000; if I do
anything nowadays, it's in the micro series using RSLogix Micro
Starter Lite)... they do have some limited notion of version control
inside the application itself, though it seems rudimentary to me.
This could prove to be helpful or extremely annoying, since even when
I connect to a PLC and go online, just to reset the RTC, it still
prompts me to save again (even though nothing changed, other than the
processor state).

You may also find this link on stackexchange helpful:
http://programmers.stackexchange.com/questions/102487/are-there-realistic-useful-solutions-for-source-control-for-ladder-logic-program

As Randall noted, L5K is just text, and RSLogix 5000 uses it,
according to this post.  It may work okay.

--Doug
