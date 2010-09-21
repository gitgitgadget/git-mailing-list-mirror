From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [tig] Re: compilation error: undefined reference to `set_tabsize'
Date: Tue, 21 Sep 2010 08:57:11 -0400
Message-ID: <AANLkTimvD32iGMwUw6vFhU8Ah+afru-x+opLGsq5Vt1j@mail.gmail.com>
References: <20100920174200.GA13017@vidovic> <loom.20100920T203217-346@post.gmane.org>
 <20100920204344.GB13017@vidovic> <20100920230559.GJ23119@bowser.ece.utexas.edu>
 <20100920231349.GK23119@bowser.ece.utexas.edu> <loom.20100921T083551-528@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Stefan Naewe <stefan.naewe@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 14:57:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy2Pi-00084D-3g
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 14:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587Ab0IUM5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 08:57:32 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44661 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823Ab0IUM5c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 08:57:32 -0400
Received: by gwj17 with SMTP id 17so1618795gwj.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 05:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=yBb//rWTsc2hattW2OCb5sTcgzLHbrya2QJ7iYtNH/8=;
        b=mcp0OIRAU9cY2hXPVGwIhIjrWOeeFY5Lq6Hr/AivXI9g36GbMn8HIWgqwQeTRUI9T+
         eGbqo13wMGG1xzjzunbHah0PyyNXcUoSkZ0IOI+ImUJQ7RnwFlnvI+4f9cUaPQx5oELy
         4vKmqqhfE/XuaYq3ohSJ25w6TuXH43jtw1Fi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Js3HP9R0U7BRDqNZCKgUmJ8K7A8aIWbWype6PKWWsJ4QWmEL6TaqgxvmsztHgNZnqs
         8wyhQu+42c8z+UXZgfNRK1YGPfUdOHBWHY3vODGlyZDW/1Y4tWIC1Gqm1Q7PIeZR/KuK
         b1XKPFEZpeCxF17GGelmX76ehVIQAiX6YgZO8=
Received: by 10.100.239.14 with SMTP id m14mr11120532anh.28.1285073851449;
 Tue, 21 Sep 2010 05:57:31 -0700 (PDT)
Received: by 10.231.39.194 with HTTP; Tue, 21 Sep 2010 05:57:11 -0700 (PDT)
In-Reply-To: <loom.20100921T083551-528@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156721>

On Tue, Sep 21, 2010 at 02:37, Stefan Naewe <stefan.naewe@googlemail.com> wrote:
> Kumar Appaiah <a.kumar <at> alumni.iitm.ac.in> writes:
>
>>
>> On Mon, Sep 20, 2010 at 06:05:59PM -0500, Kumar Appaiah wrote:
>> > Ack that this also breaks build on CentOS. The simple reason is that
>> > the ncurses version on CentOS 5.5 is ncurses-5.5, while that on Debian
>> > Lenny is 5.7+. According to the changelog, 5.6 onwards has
>> > set_tabsize, so checking for that version of ncurses might be a good
>> > option.
>>
>> I have attached a patch which uses the patch number to determine this:
>>
>
> Good. Works for me on Debian 5.0.6 and Cygwin.

Thanks both, patch applied.

-- 
Jonas Fonseca
