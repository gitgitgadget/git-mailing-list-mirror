From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] gitignore.txt: suggestions how to get literal # or ! at
 the beginning
Date: Sat, 6 Oct 2012 18:43:50 +0700
Message-ID: <CACsJy8DObOJUSdDPEsTwAKjXMYiOyf7P_6oEE9xbU6QFz7rOxQ@mail.gmail.com>
References: <1349512701-29729-1-git-send-email-pclouds@gmail.com> <01ADED0717024E6F93B7FBADB1AEAE6B@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Oct 06 13:44:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKSoE-0002oH-K2
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 13:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274Ab2JFLoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 07:44:23 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36514 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726Ab2JFLoW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 07:44:22 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so5960546iea.19
        for <git@vger.kernel.org>; Sat, 06 Oct 2012 04:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oEBu4iZp/jriYi7wrVenv5XrCuZpFYfNNdTpax7F+2E=;
        b=V8Xi5FeQHnh8GPs2cHV9XN5VCqfDetA5OPplfkUKR+h/sKv6oN25DhzBICz9lQhluJ
         DLJo80rr1je6wAreV+rTep/+QrhQ/Fid1oaiRp8kVWyOndkXYHLQzOPYELKHu34Bol41
         s2/vRmJU/GWOazOmBXz+nTJDluHL4h1ZpLp7GkTl80ojKlYF7p3Ll4/0g+10jjYU21GO
         Z5nQf03jNrSZQQJ+i1crI/NirPB6qdDRhFTLWoG14SpZncAMTeCur1RZanpqG77RHBdP
         ewMox+OeLK1D4NDOQosUtkfZmhfYgGwBncQcOOyikvjTidVSuQkh4ZdpuiWeD2BWCg8H
         9x8A==
Received: by 10.42.62.143 with SMTP id y15mr8995932ich.38.1349523861488; Sat,
 06 Oct 2012 04:44:21 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Sat, 6 Oct 2012 04:43:50 -0700 (PDT)
In-Reply-To: <01ADED0717024E6F93B7FBADB1AEAE6B@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207142>

On Sat, Oct 6, 2012 at 6:33 PM, Philip Oakley <philipoakley@iee.org> wrote:
>> Asciidoc 8.2.6 does not like me writing
>> "Put \# if you need a literal #.." so I go with "backslash" and
>> "hash" instead. `\!` displays fine both in man page and html format.
>> '!' changed to `!` because it looks clearer in monospace.
>
>
> Why not put the backslash-hash in back quotes as well to give the same
> look/feel consistency?

Because asciidoc does not like \#, '\#' nor `\#`. It just shows \
without # and I don't want to master asciidoc just to make it show \#.
-- 
Duy
