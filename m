From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 4/6] contrib/credential/osxkeychain/git-credential-osxkeychain.c:
 reduce scope of variables
Date: Wed, 16 Apr 2014 11:55:03 +0200
Message-ID: <CABPQNSa2dqzkKcaMycHQ9SUNL9tLvJGXPF4wPxv23NmFEnvrTQ@mail.gmail.com>
References: <1397640811-17719-1-git-send-email-gitter.spiros@gmail.com> <1397640811-17719-4-git-send-email-gitter.spiros@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 11:55:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaMZK-0007LS-SG
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 11:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003AbaDPJzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 05:55:46 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:59537 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856AbaDPJzn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 05:55:43 -0400
Received: by mail-ie0-f182.google.com with SMTP id y20so10270141ier.41
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 02:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Eq/0LzQYQcTqP7NtQNN4VRHd3GsVyNJAL8XcZtrvBUQ=;
        b=RYdOTji4o1FsdM8xMOGaDE2TVsoT/lZJCrEaU0vzPEY3zDBn8j7rX6XlDU9L3QEmAu
         p3rJJqgX/proKX4f629S5dIVhx0ZO9XrBERNVmaQfzm9xrYt8HGnMccXUa/opDyDxcgq
         F2aaYZfEohMWOWhO2C3SY09yHaYk03cRo4XouBJmJgQcJ0Ax1Ittodt4B8kV9cI6kyuU
         9yH2RfctH/0WkuXqvSXEQ3AnoWhKmarL/2OHlR0Togxpb0BcrwNelcq1buJE32ZGpmZk
         VMltFH3V9iJixTgE+kS7cM3AmDp0xU9eFnry4nxiUDLptaR99LVXm5kZ2MQjawA/uD7Y
         DkUg==
X-Received: by 10.50.30.6 with SMTP id o6mr3613897igh.43.1397642143088; Wed,
 16 Apr 2014 02:55:43 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Wed, 16 Apr 2014 02:55:03 -0700 (PDT)
In-Reply-To: <1397640811-17719-4-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246327>

On Wed, Apr 16, 2014 at 11:33 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  contrib/credential/osxkeychain/git-credential-osxkeychain.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> index bcd3f57..5ae09f6 100644
> --- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> +++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> @@ -163,12 +163,12 @@ static void read_credential(void)
>
>  int main(int argc, const char **argv)
>  {
> -       const char *usage =
> -               "usage: git credential-osxkeychain <get|store|erase>";
> -
>         if (!argv[1])
> +          {
> +              const char *usage =
> +                       "usage: git credential-osxkeychain <get|store|erase>";
>                 die(usage);
> -
> +          }

Again, not our code-style.
