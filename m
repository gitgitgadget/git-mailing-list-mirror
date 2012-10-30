From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Why does git-commit --template want the template to be modified ?
Date: Tue, 30 Oct 2012 15:23:25 +0100
Message-ID: <CAC9WiBgxZk3pRoj7nuqXdXKHdaHNpx+9h16o5N-vFAGVoH0NMg@mail.gmail.com>
References: <CAC9WiBjeuy8dpSnp5Jq55hs1-CJUzwpH70GZ1ZGOF2dAAeypaw@mail.gmail.com>
	<1351595365-ner-1835@calvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Tomas Carnecky <tomas.carnecky@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 15:23:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTCjE-0007GO-49
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 15:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758804Ab2J3OX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 10:23:27 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:33270 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756127Ab2J3OX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 10:23:26 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so289442oag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yUAdNynqZwhUrEm9uV5XhALiJnhpUhFFRHnvsorZ0tY=;
        b=W5w7o16OtQBWwB/oRKrdTxyhQRldWpcVwX5jpLKJeYBVZ9/LpxM4ZrGwO8NxjmYF+N
         5BYi+K3kk87aLEXb+hXAjOMHxh537TOTwjB5oAyTD6qSb0dYllURMkgVV3UyHwimd0wc
         NIx+wS8H1UZaqZfKPJH8NnzRJ5zjlC9d5OaYDefDBa6SGiIZ2F3DSO8Sk3mkHSRmW0NC
         uQvqFEPkB01fsfYkfQg+NdJ2TssS0PDPjrCoJocYhw6Ax9XoEgUa4vf0Gmb2lSDnGSjH
         bCyXk8kLRmqbNfpACyn0uJUFT+LX76LidxnHamS/FDruwni0yek9/ZuAC3yP82dXtEKb
         7UtQ==
Received: by 10.60.26.232 with SMTP id o8mr28501586oeg.7.1351607005680; Tue,
 30 Oct 2012 07:23:25 -0700 (PDT)
Received: by 10.60.93.163 with HTTP; Tue, 30 Oct 2012 07:23:25 -0700 (PDT)
In-Reply-To: <1351595365-ner-1835@calvin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208703>

Hi,

On Tue, Oct 30, 2012 at 12:09 PM, Tomas Carnecky
<tomas.carnecky@gmail.com> wrote:
> On Tue, 30 Oct 2012 11:53:08 +0100, Francis Moreau <francis.moro@gmail.com> wrote:
>> Hi,
>>
>> I'm using git-commit with the --template option. The template I'm
>> given is self sufficient for my purpose but as stated in the
>> documentation, git-commit wants the template to be edited otherwise it
>> aborts the operation.
>>
>> Is it possible to change this ?
>
> It seems you want -F instead of --template.

Yes, but I want git to still parse the log and sanitize it (remove
trailing whitespaces, comments ...)

I actually found that "-F --edit" is what I needed.

Thanks both for your answer.
-- 
Francis
