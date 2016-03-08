From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Resumable clone
Date: Tue, 8 Mar 2016 18:11:19 +0700
Message-ID: <CACsJy8A_jkvdJPgBQ_huP-t8a0ra2RfP7jZ7C-ONNm87ktYaiA@mail.gmail.com>
References: <CANtyZjSJf5_xbsBC5tUaazFT3uiEgJnx2_kHLwYwKcn50Jy_qg@mail.gmail.com>
 <CACsJy8CESL6vH22mGSLRE1OKTEbGz2Vqmsv5bY3mn_E+03wADw@mail.gmail.com>
 <xmqqoaasvkrt.fsf@gitster.mtv.corp.google.com> <CANtyZjRZzXabeWEhwCrwN_q_Zsrm1f_d+j2uDhTZeEjv3LjxaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin Wern <kevin.m.wern@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 12:12:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adFYS-0000NY-VO
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 12:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbcCHLLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 06:11:53 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35866 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbcCHLLv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 06:11:51 -0500
Received: by mail-lb0-f172.google.com with SMTP id x1so13607819lbj.3
        for <git@vger.kernel.org>; Tue, 08 Mar 2016 03:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VaqlLXdA9k1SjO2+//tmjI9xhAH5Uc8+CeEj5vGkssI=;
        b=09KuRu1pGrLX4NmrXNDgU/jAc+Re0LdD0eLklv2ICAe6HLHdfNe81KaS5/MvZj6/+C
         Qqot7OrPAAL6zsdBhOaPmFGhjDpL+wOwmDlsGSVtRsd1Yvnhe6esazj0o8Br7tLU6SW3
         ENgO9n/m3+qFv3KfJGouh8l9m3l6angGtHGy0c4lWS74b5AnSBhhvQ5AmP5yPvA+bzEh
         cDpQAsJ7BgPgDTg2/4URFasj39SJFfDo5fuY/TZgfnOplTzsrgTHCKnwYc2b7esJBh+L
         q3iNBxLmouIW2dp39kcJQj5bYXCJACXVzxayCKtiwJfVuLJVhn4p3XgT+3NdfMEAGsVc
         qnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VaqlLXdA9k1SjO2+//tmjI9xhAH5Uc8+CeEj5vGkssI=;
        b=BXP3TWdon/vPoNIQfWj2dyVxXIUzzKY7gCMvsu5oiwvydd7VuRjMhZnQvlfJej4z04
         ELZIPXvcJS15gfvYxHrF0iV6FYMns0LsQ9g5Yu0eXubKBidIdRHn/m5lGJ3NBYyRnQPp
         Bx+H+KYyQAAu+rrF/ie+0VG9VTXReh81/6pgAk08LzhF6x6Smy0aH2IczeiSSarTKvZC
         UZkJHzH/WvOvNKmHB0UY6okNbxNv3KhD3lg9xgv8KpD4tU+o68Io1uCyfXcd82nNM8EW
         TFd4iASIBTrL36BOO/GNVteqj4JhkGMLgCYaiXrUAHe4mn3lmXL0s1FdODgyv/3vKqqH
         97dQ==
X-Gm-Message-State: AD7BkJJd+YNVhMlCBW4rLvYlHBB3hqerK68LJYGjAdiI/5wKqZGmdxszPNOFLCyYJ+L1PRUF9FRXdw0XcraL9w==
X-Received: by 10.25.161.131 with SMTP id k125mr9673272lfe.83.1457435509219;
 Tue, 08 Mar 2016 03:11:49 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Tue, 8 Mar 2016 03:11:19 -0800 (PST)
In-Reply-To: <CANtyZjRZzXabeWEhwCrwN_q_Zsrm1f_d+j2uDhTZeEjv3LjxaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288426>

On Tue, Mar 8, 2016 at 10:33 AM, Kevin Wern <kevin.m.wern@gmail.com> wrote:
> Hey Junio and Duy,
>
> Thank you for your thorough responses! I'm new to git dev, so it's
> extremely helpful.
>
>> - The server side endpoint does not have to be, and I think it
>> should not be, implemented as an extension to the current
>> upload-pack protocol. It is perfectly fine to add a new "git
>> prime-clone" program next to existing "git upload-pack" and
>> "git receive-pack" programs and drive it through the
>> git-daemon, curl remote helper, and direct execution over ssh.
>
> I'd like to work on this, and continue through to implementing the
> prime_clone() client-side function.

Great! Although I think you started with the most configurable part,
something to work out I guess.

> From what I understand, a pattern exists in clone to download a
> packfile when a desired object isn't found as a resource. In this
> case, if no alternative is listed in http-alternatives, the client
> automatically checks the pack index(es) to see which packfile contains
> the object it needs.

I don't follow this. What is "a resource"?

> However, the above is a fallback. What I believe *doesn't* exist is a
> way for the server to say, "I have a resource, in this case a
> full-history packfile

ah a resource could be the pack file to be downloaded, ok..

> , and I *prefer* you get that file instead of
> attempting to traverse the object tree." This should be implemented in
> a way that is extensible to other resource types moving forward.
>
> I'm not sure how the server should determine the returned resource. A
> packfile alone does not guarantee the full repo history

That's for the later part. At this point, I think the update "git
clone" will request the new service you're writing and ask "do you
have a resumable pack I can download?" and it can return an URL. Then
prime_clone() proceeds to download and figure out what's in that pack.

Yeah the determination is tricky, it depends on server setup. Let's
start with select the pack for download first because there could be
many of them. A heuristic (*) of choosing the biggest one in
$GIT_DIR/objects/pack is probably ok for now (we don't need full
history, "the biggest part of history" is good enough). Then we get
the pack file name, which can be used as pack ID.

For the simplest setup, I suppose the admin would give us an URL
prefix (or multiple prefixes), e.g. http://myserver.com/cache-here/
and we are supposed to append the pack file name to it, and the full
URL would be http://myserver.com/cache-here/pack-$SHA1.pack. This is
what the new service will return to git-clone.

For more complex setup, I guess the admin can provide a script that
takes pack id as key and returns the list of URLs for us. They can
give us the path to this script via config file.

(*) The source of producing this cached pack (and maybe sending them
to CDN) is git-repack. But when it's done and how it's done is really
up to admins. So the admin really needs to provide us a script or
something that provides this info back, if we want to avoid
heuristics. Such a script can even choose to ignore the given pack id
and output URLs based on repository identify only.

> , and I'm not
> positive checking the idx file for HEAD's commit hash ensures every
> sub-object is in that file (though I feel it should, because it is
> delta-compressed). With that in mind, my best guess at the server
> logic for packfiles is something like:
>
> Do I have a full history packfile, and am I configured to return one?
> - If yes, then return an answer specifying the file url and type (packfile)
> - Otherwise, return some other answer indicating the client must go
> through the original cloning process (or possibly return a different
> kind of file and type, once we expand that capability)

Well, the lack of this new service should be enough for git-clone to
fall back to normal cloning protocol. The admin must enable this
service in git-daemon first if they want to use it. If there's no
suitable URL to show, it's ok to just disconnect. git-clone must be
able to deal with that and fall back.

> Which leaves me with questions on how to test the above condition. Is
> there an expected place, such as config, where the user will specify
> the type of alternate resource, and should we assume some default if
> it isn't specified? Can the user optionally specify the exact file to
> use (I can't see why because it only invites more errors)? Should the
> specification of this option change git's behavior on update, such as
> making sure the full history is compressed? Does the existence of the
> HEAD object in the packfile ensure the repo's entire history is
> contained in that file?

I think some of these questions are basically "ask admins", the other
half we can deal with when implementing prime_clone().

Following up what I wrote above. Suppose your service's name is
clone-download (or any other name), the config variable
daemon.clonedownload must be set in order to turn this service on.
Without it, git-clone falls back to normal clone. Then we could either
have config clonedownload.prefix or clonedownload.script. Or something
like that.

Also, we made a mistake before with transport protocol where the
server talks first. I'm thinking this time, maybe we do it
differently. git-clone connects to the service, then tells the server
about its capability and whatever else (e.g. physical localtion, the
max number of URLs it wants to receive...). The server waits for that
first, then it can send URLs back to the client, then disconnect.

Unless there's something very sepcial, I think we just follow current
protocol and use pkt-line for communication (see "pkt-line Format" in
Documentation/technical/pack-protocol.txt). We send one URL per
pkt-line, terminated with null pkt-line.

All this is about full duplex connections (git:// or ssh://). Smart
http is not mentioned. But I think a simple GET request is enough for
this (you'll have to touch http.c, but that can wait).

> Also, for now I'm assuming the same options should be available for
> prime-clone as are available for upload-pack (--strict,
> --timeout=<n>). Let me know if any other features are necessary.
> Also, let me know if I'm headed in the complete wrong direction...

Heh.. I didn't know upload-pack took  --timeout :D --strict should be
there (repository discovery is the same everywhere). Not so sure about
--timeout (upload-pack can take a long time so timeout gives more
resource control, this new services should be instant)
-- 
Duy
