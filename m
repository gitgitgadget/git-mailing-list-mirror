From: Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Mar 2015, #07; Fri, 20)
Date: Fri, 20 Mar 2015 16:29:21 -0700
Message-ID: <CAGZ79kapUtq0DbcD65v_aKmCXHz3hjSkEh1MJH1nWr2DhSa5hw@mail.gmail.com>
References: <xmqqr3sjcopt.fsf@gitster.dls.corp.google.com>
	<423416FC-1048-4D3A-B997-F1F796627242@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 00:29:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ6M3-0004uQ-6W
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 00:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbbCTX3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 19:29:23 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:34685 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbbCTX3W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 19:29:22 -0400
Received: by iedfl3 with SMTP id fl3so1421334ied.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 16:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=geMUq0crr7PbGlRF18nl0RmtpVeCDe08nMntfDDJ5Yg=;
        b=GESZj5yvJ1UEj8SvOGZrZ4+UNhA1QxIiDhPV4jAE3I8ORQkyGjNf8kaK+iYiY9j4IP
         JQvR9Fj0vkfRg0BSITakhzMblBOrGc9a2AvbuVcVIX0H3h7kYe65hz9WsHPeJuy6MFLV
         /bbqxMKSxsz1xMt0223hZamcW9ch2qa/hYjcvjfCsLAMz04Pj39zp6B7RyAEOOri3iW0
         X2KFRZsSQRO9IWWNCbPDvGMG4jD3zJuVu3jKkI5eZcI0vl6gfdF6zUqZXUWZfErEe3Z1
         YmgKrkSGYWK4pZB9xuANuSIG32id5qD/AiX6+uMb7iWv4Xn8xB6Mt2WxYyl2meO/Gf/5
         WuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=geMUq0crr7PbGlRF18nl0RmtpVeCDe08nMntfDDJ5Yg=;
        b=eOBNKXjDKoMw8mJ7cyzHpA8vazXvrZ9724AIxsc36/Bso42fc94hIt2ScY8XkTE1/b
         12ZlJX9Q60+wsKJDStu0m0NKy25ToP9PY4MPuv4Zf/CJzwKPg7WJmN5BMYg+y5mQSM9K
         9sypGIKNnoETWCM6gKbwJzYTzGecxP2KAYfAQ8sfeTEjWoK0wO2MdkpUOXumFsZEUe/o
         WE3mr0vdsjxUwbod4PvhhH6TJdJHafaNhr2MQ8AmHRpLAnotxNpn49bJiqBglxdRuYkM
         0S4yRzCdc7SXY0HEd60d+qIT/a3q63/3jBjKbqSLRI75DOWo+i+8o3CRd1ePBl28bPEx
         Ytxw==
X-Gm-Message-State: ALoCoQmY0EEYSQrDMJqk3ct27/TQJMEit4DVn+8OX6VUIQNe1xDktDXv4qc+6havuJlnp9jZh+Fi
X-Received: by 10.50.122.68 with SMTP id lq4mr262835igb.10.1426894161554; Fri,
 20 Mar 2015 16:29:21 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Fri, 20 Mar 2015 16:29:21 -0700 (PDT)
In-Reply-To: <423416FC-1048-4D3A-B997-F1F796627242@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265980>

On Fri, Mar 20, 2015 at 4:24 PM, Kyle J. McKay <mackyle@gmail.com> wrote:

> Has this been merged to 'next'?

Usually Junio writes the mail first and then does a git push <all the branches>
just before being done for the day. At least that's my suspicion as an
observer of
the timing when git fetch returns new shiny stuff and when these
emails are sent.
