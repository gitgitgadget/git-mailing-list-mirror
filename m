From: Akshay Aurora <akshayaurora@yahoo.com>
Subject: Re: [PATCH][GSoC] revision: forbid --graph and --no-walk usage
Date: Fri, 6 Mar 2015 17:41:20 +0530
Message-ID: <CAPGnZZkxTMDqfJEogxy2hGJv033t_ehU_LucChpVqqKWRLxR=w@mail.gmail.com>
References: <1425582632-28273-1-git-send-email-akshayaurora@yahoo.com>
	<CAPGnZZ=WJcd=GWkMqq93RXpJz8jvqnaZctcF2Tni3qkO2vhSOw@mail.gmail.com>
	<CAF7_NFRKetzHEB5tfENA=A-wwStwJG7yCbUKYLZos+0WSekeig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Fri Mar 06 13:11:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTr6G-00064N-3i
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 13:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707AbbCFMLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 07:11:23 -0500
Received: from mail-wg0-f43.google.com ([74.125.82.43]:35671 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbbCFMLW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 07:11:22 -0500
Received: by wggz12 with SMTP id z12so59793732wgg.2
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 04:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MV3aYK4mmui5WpHQS4cz7umSVKDKNuhyStaWerD8ak0=;
        b=L2Akuy2ZM1oiMwv16po2iwvI4LvDdumyUVVfjp71EooCP/FeDu7NaDhqhcCZZUUO8x
         VEEmDDUdzTyqXYrBmUEH0ScSWqwggCKO8F4pXWYRDMx/68GR8vqjOzgmPXybZF4plEx7
         0xXuwFRaWjVLl7wQ2NtChAu6RDOEe3/Mh1gGVUC3P+F7L26fJx/fgI28YPeHL99KZvsX
         Pl7fW9HKxzdCTuXtU3Uvmpyi+OL0zYUK00WJHtHf+UKfqhBwAXxjrHaBIjAkXNJXf7XS
         3TQVkBhWTegXQENyVEtHJXKZhFNYZ1srhBDlxeIXn1KMnEZpKEVKglvMMyBHkJFYED0K
         1LgQ==
X-Received: by 10.194.239.134 with SMTP id vs6mr15990235wjc.158.1425643880830;
 Fri, 06 Mar 2015 04:11:20 -0800 (PST)
Received: by 10.27.45.1 with HTTP; Fri, 6 Mar 2015 04:11:20 -0800 (PST)
In-Reply-To: <CAF7_NFRKetzHEB5tfENA=A-wwStwJG7yCbUKYLZos+0WSekeig@mail.gmail.com>
X-Google-Sender-Auth: hCabJdS9HUopU1N_IyZD8j75B8w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264919>

Thanks for replying. I'll try sending the patch directly using gmail
smtp servers next time.

Going by the description of the options. I doubt --graph and --no-walk
would ever make sense together.
So my patch forbids these two options together for all commands
calling setup_revisions(). And isn't specific to just `git log`.

Also, seeing other patches to this microproject. I think I should also
update Documentation for rev-list-options.

Do you think we need a test for this? Would a test using only `git
log` be suffice?

On Fri, Mar 6, 2015 at 2:07 PM, Max Kirillov <max@max630.net> wrote:
> On Fri, Mar 6, 2015 at 7:08 AM, Akshay Aurora <akshayaurora@yahoo.com> wrote:
>> Not sure, why this mail is not showing on Gmane.
>> I used git to send the email, and tested it by sending the patch to
>> myself before sending it to the list.
>
> Gmail knows: "Why is this message in Spam? It has a from address in
> yahoo.com but has failed yahoo.com's required tests for
> authentication.  Learn more" Probably filtering settings are less
> strict.
>
> I guess you should use authenticated SMTP thought your email hoster,
> yahoo here in git-send-email (something like --smtp-server and
> --smtp-user options, it will ask for password interactively) to avoid
> it.



-- 
AA
