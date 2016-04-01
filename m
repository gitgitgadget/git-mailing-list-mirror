From: shawn wilson <ag4ve.us@gmail.com>
Subject: Re: git alias quoting help
Date: Fri, 1 Apr 2016 02:10:41 -0400
Message-ID: <CAH_OBifdLkszB7ZnKWBuZv8AFmKC9-RLZhxK_tmC9+bNJzXrXA@mail.gmail.com>
References: <CAH_OBievBBjzLwPZf3-qLn-SQyJG0UHhbdkvyZFfC8b-TsTUJQ@mail.gmail.com>
 <CAH_OBie1Bc==wPByestESHz-K8ezC7f5A1D=t1SsP9=Sd-y-eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 01 08:11:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alsIc-0000L1-89
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 08:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758008AbcDAGLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 02:11:03 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33367 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754452AbcDAGLB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 02:11:01 -0400
Received: by mail-pa0-f49.google.com with SMTP id zm5so83452730pac.0
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 23:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=cHMbYsfXCaDGVeQ4amATC04wG1lJDBFKxzadOv+1r48=;
        b=NmjVUNOCnYW0FTWQcOHlYLL13SghUBpuLpYVU8ievvI8o5MqTWlNclMIZQnbCIi8ml
         SVSY2UMGp3pK7R6FW9lKxtg4xih8nsX9Yd0zOnk/WceTW7Lxc6ebuuiCqDhSMAH2uUfZ
         3VF5bIN/kZuHG35+EPJHGb5ndkwGMdROEHq8HnMnf2FVt63HDCrglEQWpFnQQGFLWCpY
         A/VnQTAR7vGT+qT3s0V/MqBSP5AjnWGlRJe7qt+J0weZ1MWIBcWirrKfYwrRmVLvhJAF
         hkbtTeh4yE6t0jHA6jmL4ygVJrWB1yIYf1vwh6mSH1jcFGnC+aVFwxWcS92ujirMhOL7
         wC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=cHMbYsfXCaDGVeQ4amATC04wG1lJDBFKxzadOv+1r48=;
        b=Mkt0Qjmm+6LKXLLGa9Gc1HmTELQFnpmVg74+XCR2n87b7jcQUbK81u4CsMdvJVtdlY
         5d8H5OZ4boTYQnKpqoNK03/lC4Ru70m7zczWRd0w1Ro8Tu6wKw6QL6olrtQ/uwVTTnlk
         phUCZ4OKED2Hy5CG/kgCtr+vrdFswMOhhsc09plX42jx+sJ9hTXQvRV1ZWxyF9zSejEm
         Ji0lWgf4CqgMaOqkd1eZO+fZ4zjo/YBDKJaLg/0RiLUC9e4bckaEqMY0Jb0ui5awiMn9
         P9xn7KhBcJCn0JlJBOT9MAxiK7/S7Fqk13JkCriHi5+I1mi89uMjajjq0P8F6PmY6r8I
         a2DQ==
X-Gm-Message-State: AD7BkJLkH5KFtsGG3FnsnMjkeXQGpOMvnxjzZrgAke1QSZRRfS52WeniLumqFeGvFTj+kSPj18XscDn5Hsr3Ig==
X-Received: by 10.66.136.78 with SMTP id py14mr21361197pab.113.1459491060766;
 Thu, 31 Mar 2016 23:11:00 -0700 (PDT)
Received: by 10.66.5.163 with HTTP; Thu, 31 Mar 2016 23:10:41 -0700 (PDT)
In-Reply-To: <CAH_OBie1Bc==wPByestESHz-K8ezC7f5A1D=t1SsP9=Sd-y-eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290508>

FWIW, I (finally) found two projects that like they'll do what I want:
git-splits and git_filter
The later was lacking in documentation and after the build I couldn't
figure it out at a glance and I think git-splits will DWIW.

On Thu, Mar 31, 2016 at 10:27 AM, shawn wilson <ag4ve.us@gmail.com> wrote:
> BTW, just trying to get filter-branch to interpret the bash script
> string correctly now and it still isn't working:
>
> git filter-branch -f --prune-empty --index-filter "\
>   git ls-files -s | \
>   sed \"s-\\t\\\"*-&${1}-\" | \
>   GIT_INDEX_FILE=\$GIT_INDEX_FILE.new \
>   git update-index --index-info && \
>     mv \$GIT_INDEX_FILE.new \$GIT_INDEX_FILE \
> " HEAD
>
>  I'm guessing bash is grabbing my actual bash shell is grabbing the
> GIT_INDEX_FILE declaration for itself. If this is the case, I'm not
> sure how to stop it - tried var\=\$var.new and that passes the '\='
> which totally messes things up.
>
> Rewrite ef54b77e59c7f4e18f00168ba88a8d2fee795802 (1/76)mv: cannot stat
> `/<repo path>/.git-rewrite/t/../index.new': No such file or directory
> index filter failed:   git ls-files -s |   sed
> "s-\t\"*-&cookbooks/adjoin/-" |   GIT_INDEX_FILE=$GIT_INDEX_FILE.new
> git update-index --index-info &&     mv $GIT_INDEX_FILE.new
> $GIT_INDEX_FILE
>
> On Wed, Mar 30, 2016 at 12:13 AM, shawn wilson <ag4ve.us@gmail.com> wrote:
>> I've also tried to make this a plain bash script (w/o the function or
>> if statements and am failing at the same place). The issue seems to be
>> with the quoting in the filter-branch | ls-files bit. Also, the end
>> goal here is to be able to move a directory from one repo and keep the
>> history. While this works if I do it at the command line, it's just
>> too many steps (is tedious). Also, if there's a way to do the same
>> thing with multiple directories in one shot, (or make this work with
>> something like: cookbooks/{a,b,c} # as a parameter) that'd be perfect.
>>
>>   reapdir = "!f() { \
>>     if [ -d "$1" ] ; then \
>>       git filter-branch --prune-empty --subdirectory-filter "$1" -- --all && \
>>       git gc --aggressive && \
>>       git prune && \
>>       git filter-branch -f --prune-empty --index-filter '\
>>         git ls-files -s \
>>           | sed \"s-\\t-&$1-\" \
>>           | GIT_INDEX_FILE=$GIT_INDEX_FILE.new git update-index
>> --index-info && \
>>             mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE'; \
>>     else \
>>       echo "No directory $1"; \
>>     fi; }; \
>>   f"
